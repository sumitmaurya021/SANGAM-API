module Api
  module V1
    module Auth
      class UnlocksController < ApplicationController
        before_action :authenticate_request!, except: [:show, :create]

        def show
          user = User.find_by(unlock_token: params[:unlock_token])
          
          if user && user.unlock_token.present?
            user.update(
              locked_at: nil,
              unlock_token: nil,
              failed_attempts: 0
            )
            render_success(message: 'Account unlocked successfully')
          else
            render_error(message: 'Invalid unlock token', status: :unprocessable_entity)
          end
        end

        def create
          user = User.find_by(email: params[:email])
          return render_error(message: 'User not found', status: :not_found) unless user
          
          unless user.locked_at?
            return render_error(message: 'Account is not locked', status: :unprocessable_entity)
          end

          # Generate unlock token
          user.update(unlock_token: SecureRandom.urlsafe_base64)
          
          # In a real app, send email here
          # NotificationMailer.unlock_email(user).deliver_later

          render_success(message: 'Unlock instructions sent')
        end
      end
    end
  end
end
