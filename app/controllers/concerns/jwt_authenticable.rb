module JwtAuthenticable
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secret_key_base.to_s

  included do
    def encode_token(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode_token(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end

    def authenticate_request!
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      decoded = decode_token(token)
      
      if decoded
        @current_user = User.find_by(id: decoded[:user_id])
        @current_user.update_columns(last_seen_at: Time.current, online: true) if @current_user
      end

      unless @current_user
        render_error(message: 'Unauthorized', status: :unauthorized)
      end
    end

    def set_current_user_if_present
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      if token
        decoded = decode_token(token)
        if decoded
          @current_user = User.find_by(id: decoded[:user_id])
        end
      end
    end

    def current_user
      @current_user
    end
  end
end
