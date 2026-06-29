class SendOtpEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, otp)
    user = User.find_by(id: user_id)
    return unless user

    OtpMailer.otp_email(user, otp).deliver_now
  rescue => e
    Rails.logger.error "SendOtpEmailJob failed for user #{user_id}: #{e.message}"
  end
end
