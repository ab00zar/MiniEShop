module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
    rescue_from ArgumentError, with: :bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def record_not_found(exception)
    respond_with_error(exception.message, :not_found)
  end

  def record_invalid(exception)
    respond_with_error(exception.message, :unprocessable_entity)
  end

  def bad_request(exception)
    respond_with_error(exception.message, :bad_request)
  end

  def internal_server_error(exception)
    Rails.logger.error("Unexpected error: #{exception.class} - #{exception.message}\n#{exception.backtrace.join("\n")}")
    respond_with_error("An unexpected error occurred", :internal_server_error)
  end

  def respond_with_error(message, status)
    render json: {
      success: false,
      error: {
        status: status,
        message: message
      }
    }, status: status
  end
end
