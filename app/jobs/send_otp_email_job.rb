class SendOtpEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id, otp)
    user = User.find_by(id: user_id)
    return unless user

    send_via_brevo(user, otp)
  end

  private

  def send_via_brevo(user, otp)
    require 'net/http'
    require 'json'

    uri = URI('https://api.brevo.com/v3/smtp/email')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['accept'] = 'application/json'
    request['content-type'] = 'application/json'
    request['api-key'] = ENV['BREVO_API_KEY']

    request.body = {
      sender: { name: 'Sangam', email: ENV.fetch('MAILER_FROM', 'noreply@sangam.app') },
      to: [{ email: user.email, name: user.name }],
      subject: "Sangam — Your OTP Code: #{otp}",
      textContent: "Your OTP code is: #{otp}. It expires in 10 minutes.",
      htmlContent: "<p>Hello #{user.name},</p><p>Your OTP code is: <strong>#{otp}</strong></p><p>It expires in 10 minutes.</p>"
    }.to_json

    response = http.request(request)

    if response.code.to_i == 201
      Rails.logger.info "OTP email sent successfully to #{user.email}"
    else
      Rails.logger.error "Brevo API error: #{response.code} - #{response.body}"
    end
  rescue => e
    Rails.logger.error "SendOtpEmailJob failed for user #{user_id}: #{e.message}"
  end
end
