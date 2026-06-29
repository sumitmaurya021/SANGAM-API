class OtpMailer < ApplicationMailer
  def otp_email(user, otp)
    @user = user
    @otp = otp
    mail(
      to: @user.email,
      subject: "Sangam — Your OTP Code: #{@otp}"
    )
  end
end
