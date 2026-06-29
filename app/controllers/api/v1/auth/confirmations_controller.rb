module Api
  module V1
    module Auth
      class ConfirmationsController < ApplicationController
        before_action :authenticate_request!, except: [:show]

        def show
          user = User.find_by(confirmation_token: params[:confirmation_token])
          
          if user && user.confirmation_token.present? && user.confirmation_sent_at > 2.days.ago
            user.update(
              confirmed_at: Time.current,
              confirmation_token: nil
            )
            render_success(message: 'Email confirmed successfully')
          else
            render_error(message: 'Invalid or expired confirmation token', status: :unprocessable_entity)
          end
        end

        def create
          user = User.find_by(email: params[:email])
          return render_error(message: 'User not found', status: :not_found) unless user
          
          if user.confirmed?
            return render_error(message: 'Email already confirmed', status: :unprocessable_entity)
          end

          # Generate confirmation token
          user.update(
            confirmation_token: SecureRandom.urlsafe_base64,
            confirmation_sent_at: Time.current
          )
          
          # In a real app, send email here
          # NotificationMailer.confirmation_email(user).deliver_later

          render_success(message: 'Confirmation email sent')
        end
      end
    end
  end
end
