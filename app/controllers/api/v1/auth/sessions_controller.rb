module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        before_action :authenticate_request!, only: [:destroy]

        def create
          user = User.find_by(email: params[:email]) || User.find_by(phone_number: params[:phone_number])

          if user&.authenticate(params[:password])
            # If 2FA/OTP is required on login:
            user.generate_otp!
            # Send OTP here via SMS/Email
            render_success(message: 'Login successful. Please verify your OTP.', data: { user_id: user.id, require_otp: true })
            
            # Alternatively, if OTP is only for registration, we could just return token here:
            # token = encode_token({ user_id: user.id })
            # render_success(message: 'Login successful', data: { token: token, user: user.as_json(...) })
          else
            render_error(message: 'Invalid credentials', status: :unauthorized)
          end
        end

        def destroy
          # JWT is stateless, but we can implement token blacklisting if needed
          # For now, client just deletes the token
          render_success(message: 'Logged out successfully')
        end
      end
    end
  end
end
