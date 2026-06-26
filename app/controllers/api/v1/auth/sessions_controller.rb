module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        before_action :authenticate_request!, only: [:destroy]

        def create
          user = User.find_by(email: params[:email]) || User.find_by(phone_number: params[:phone_number])

          if user&.authenticate(params[:password])
            # If the user is NOT verified, they must verify their OTP first.
            unless user.verified?
              otp = user.generate_otp!
              begin
                OtpMailer.otp_email(user, otp).deliver_now
              rescue => e
                Rails.logger.error "Failed to send verification OTP: #{e.message}"
              end
              return render_success(message: 'Account not verified. Please verify your OTP.', data: { user_id: user.id, require_otp: true })
            end

            # Check if remember_token is passed and is valid
            if params[:remember_token].present?
              token_hash = Digest::SHA256.hexdigest(params[:remember_token])
              remember_token_record = user.remember_tokens.find_by(token_hash: token_hash)
              
              if remember_token_record && !remember_token_record.expired?
                # Skip OTP verification! Give JWT token immediately
                token = encode_token({ user_id: user.id })
                return render_success(
                  message: 'Login successful',
                  data: {
                    token: token,
                    user: user.as_json(except: [:password_digest, :otp_secret])
                  }
                )
              end
            end

            # Otherwise, OTP is required. Set remember_me_pending if remember_me is true
            user.update(remember_me_pending: params[:remember_me] == true)
            otp = user.generate_otp!
            begin
              OtpMailer.otp_email(user, otp).deliver_now
            rescue => e
              Rails.logger.error "Failed to send login OTP: #{e.message}"
            end

            render_success(message: 'Login successful. Please verify your OTP.', data: { user_id: user.id, require_otp: true })
          else
            render_error(message: 'Invalid credentials', status: :unauthorized)
          end
        end

        def destroy
          # On logout, revoke all trusted-device tokens for this user
          @current_user.remember_tokens.destroy_all
          render_success(message: 'Logged out successfully')
        end
      end
    end
  end
end
