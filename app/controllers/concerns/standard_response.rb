module StandardResponse
  extend ActiveSupport::Concern

  included do
    def render_success(message: 'Operation successful', data: {}, status: :ok)
      render json: {
        success: true,
        message: message,
        data: data
      }, status: status
    end

    def render_error(message: 'Operation failed', errors: {}, status: :unprocessable_entity)
      render json: {
        success: false,
        message: message,
        errors: errors
      }, status: status
    end
  end
end
