module Api
  module V1
    module Auth
      class OtpsController < ApplicationController
        def verify
          user = User.find_by(id: params[:user_id])
          
          unless user
            return render_error(message: 'User not found', status: :not_found)
          end

          if user.otp_attempts >= 5
            return render_error(message: 'Too many failed attempts. Please request a new OTP.', status: :unauthorized)
          end

          if user.valid_otp?(params[:otp])
            user.clear_otp!
            user.update(verified: true, confirmed_at: Time.current)
            
            token = encode_token({ user_id: user.id })
            response_data = {
              token: token,
              user: user.as_json(except: [:password_digest, :otp_secret])
            }

            # Generate remember_token if requested
            if params[:remember_me] == true || params[:remember_me] == 'true' || user.remember_me_pending?
              raw_remember_token = SecureRandom.hex(32)
              token_hash = Digest::SHA256.hexdigest(raw_remember_token)
              user.remember_tokens.create!(
                token_hash: token_hash,
                expires_at: 7.days.from_now
              )
              response_data[:remember_token] = raw_remember_token
              user.update(remember_me_pending: false)
            end

            render_success(message: 'OTP verified successfully', data: response_data)
          else
            user.reload
            attempts_left = 5 - user.otp_attempts
            message = if attempts_left <= 0
                        user.update(otp_secret: nil, otp_expires_at: nil)
                        'Too many failed attempts. Please request a new OTP.'
                      else
                        "Invalid or expired OTP. #{attempts_left} attempts remaining."
                      end
            render_error(message: message, status: :unauthorized)
          end
        end

        def resend
          user = User.find_by(id: params[:user_id])
          
          unless user
            return render_error(message: 'User not found', status: :not_found)
          end

          otp = user.generate_otp!
          begin
            OtpMailer.otp_email(user, otp).deliver_now
          rescue => e
            Rails.logger.error "Failed to resend OTP: #{e.message}"
          end
          render_success(message: 'OTP resent successfully')
        end
      end
    end
  end
end
