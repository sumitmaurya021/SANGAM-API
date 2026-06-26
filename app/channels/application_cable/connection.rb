module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      current_user.update_columns(online: true, last_seen_at: Time.current)
      broadcast_presence(true)
    end

    def disconnect
      return unless current_user
      current_user.update_columns(online: false, last_seen_at: Time.current)
      broadcast_presence(false)
    end

    private

    def find_verified_user
      token = request.params[:token]
      if token.present?
        begin
          secret_key = Rails.application.secret_key_base.to_s
          decoded = JWT.decode(token, secret_key)[0]
          user = User.find_by(id: decoded['user_id'])
          return user if user
        rescue JWT::DecodeError, JWT::ExpiredSignature
          # Ignore
        end
      end
      reject_unauthorized_connection
    end

    def broadcast_presence(online)
      ActionCable.server.broadcast(
        "user_presence",
        {
          type:         'presence_update',
          user_id:      current_user.id,
          online:       online,
          last_seen_at: current_user.last_seen_at&.iso8601
        }
      )
    end
  end
end
