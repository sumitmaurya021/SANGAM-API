module Authorization
  extend ActiveSupport::Concern

  included do
    def authorize_super_admin!
      render_error(message: 'Unauthorized', status: :forbidden) unless @current_user&.super_admin?
    end

    def authorize_owner!(record, user_attribute = :user_id)
      unless record.public_send(user_attribute) == @current_user&.id || @current_user&.super_admin?
        render_error(message: 'Unauthorized', status: :forbidden)
      end
    end
  end
end
