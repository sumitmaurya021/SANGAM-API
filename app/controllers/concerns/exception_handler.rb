module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(message: 'Record not found', errors: e.message, status: :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(message: 'Validation failed', errors: e.record.errors.messages, status: :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do |e|
      render_error(message: 'Missing parameter', errors: e.message, status: :bad_request)
    end

    rescue_from ArgumentError do |e|
      render_error(message: 'Invalid argument', errors: e.message, status: :bad_request)
    end

    # Global handler for standard errors in production (optional, could be refined)
    unless Rails.env.development?
      rescue_from StandardError do |e|
        render_error(message: 'Internal server error', errors: e.message, status: :internal_server_error)
      end
    end
  end
end
