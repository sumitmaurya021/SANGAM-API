module Api
  module V1
    module Auth
      class OtpsController < ApplicationController
        def verify
          user = User.find_by(id: params[:user_id])
          
          unless user
            return render_error(message: 'User not found', status: :not_found)
          end

          if user.valid_otp?(params[:otp])
            user.clear_otp!
            user.update(verified: true, confirmed_at: Time.current)
            
            token = encode_token({ user_id: user.id })
            render_success(message: 'OTP verified successfully', data: { token: token, user: user.as_json(except: [:password_digest, :otp_secret]) })
          else
            render_error(message: 'Invalid or expired OTP', status: :unauthorized)
          end
        end

        def resend
          user = User.find_by(id: params[:user_id])
          
          unless user
            return render_error(message: 'User not found', status: :not_found)
          end

          user.generate_otp!
          # In a real app, send OTP via SMS/Email here
          render_success(message: 'OTP resent successfully')
        end
      end
    end
  end
end
