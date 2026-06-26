module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        def create
          user = User.new(user_params)
          user.unconfirmed_email = user.email # Using this field from devise to track verification
          user.verified = false # Mark as unverified
          
          if user.save
            otp = user.generate_otp!
            begin
              OtpMailer.otp_email(user, otp).deliver_now
            rescue => e
              Rails.logger.error "Failed to send registration OTP: #{e.message}"
            end
            render_success(message: 'Registration initiated. Please verify your OTP.', data: { user_id: user.id }, status: :created)
          else
            render_error(message: 'Registration failed', errors: user.errors.messages)
          end
        end

        private

        def user_params
          params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
        end
      end
    end
  end
end
