module Api
  module V1
    module Auth
      class OmniauthCallbacksController < ApplicationController
        before_action :authenticate_request!, except: [:callback]

        def callback
          provider = params[:provider]
          uid = params[:uid]
          email = params[:email]
          name = params[:name]

          if provider.blank? || uid.blank? || email.blank?
            return render_error(message: 'Provider, uid, and email are required', status: :bad_request)
          end

          # Find existing user by provider/uid or email
          user = User.find_by(provider: provider, uid: uid.to_s)
          user ||= User.find_by(email: email.downcase.strip)

          if user
            # Link provider if it was found by email only
            user.update_columns(provider: provider, uid: uid.to_s) if user.provider.blank?
          else
            # Create new user
            user = User.new(
              provider: provider,
              uid: uid.to_s,
              email: email.downcase.strip,
              name: name || email.split('@').first,
              password: SecureRandom.hex(16),
              confirmed_at: Time.current
            )
            unless user.save
              return render_error(message: 'Failed to create user from OAuth', errors: user.errors.messages)
            end
            
            # Send welcome email for brand-new OAuth users
            begin
              NotificationMailer.welcome_email(user).deliver_later
            rescue => e
              Rails.logger.error "Omniauth welcome email failed: #{e.message}"
            end
          end

          token = generate_jwt(user)
          render_success(
            message: 'Authentication successful',
            data: {
              user: UserBlueprint.render_as_hash(user, view: :normal),
              token: token
            }
          )
        end
      end
    end
  end
end
