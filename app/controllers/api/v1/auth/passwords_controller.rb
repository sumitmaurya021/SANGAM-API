module Api
  module V1
    module Auth
      class PasswordsController < ApplicationController
        before_action :authenticate_request!, only: [:update]

        def forgot
          unless params[:email].present? || params[:phone_number].present?
            return render_error(message: 'Email or phone number is required', status: :bad_request)
          end
          user = User.find_by(email: params[:email]) if params[:email].present?
          user ||= User.find_by(phone_number: params[:phone_number]) if params[:phone_number].present?
          
          if user
            otp = user.generate_otp!
            OtpMailer.otp_email(user, otp).deliver_now if user.email.present?
            render_success(message: 'Password reset OTP sent successfully', data: { user_id: user.id })
          else
            render_error(message: 'User not found', status: :not_found)
          end
        end

        def reset
          user = User.find_by(id: params[:user_id])
          return render_error(message: 'User not found', status: :not_found) unless user

          if user.valid_otp?(params[:otp])
            if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
              user.clear_otp!
              render_success(message: 'Password reset successfully')
            else
              render_error(message: 'Failed to reset password', errors: user.errors.messages)
            end
          else
            render_error(message: 'Invalid or expired OTP', status: :unauthorized)
          end
        end

        def update
          if @current_user.authenticate(params[:current_password])
            if @current_user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
              render_success(message: 'Password changed successfully')
            else
              render_error(message: 'Failed to change password', errors: @current_user.errors.messages)
            end
          else
            render_error(message: 'Incorrect current password', status: :unauthorized)
          end
        end
      end
    end
  end
end
