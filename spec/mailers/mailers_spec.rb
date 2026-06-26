require 'rails_helper'

RSpec.describe 'Mailers', type: :mailer do
  describe OtpMailer do
    describe '#otp_email' do
      let(:user) { create(:user, email: 'user@example.com') }
      let(:mail) { OtpMailer.otp_email(user, '123456') }

      it 'renders the headers' do
        expect(mail.subject).to include('Your OTP Code: 123456')
        expect(mail.to).to eq(['user@example.com'])
        expect(mail.from).to eq(['noreply@sangam.app'])
      end

      it 'renders the body' do
        expect(mail.body.encoded).to include('123456')
        expect(mail.body.encoded).to include('One-Time Password')
      end
    end
  end

  describe NotificationMailer do
    describe '#welcome_email' do
      let(:user) { create(:user, email: 'user@example.com', name: 'John Doe') }
      let(:mail) { NotificationMailer.welcome_email(user) }

      it 'renders headers and name' do
        expect(mail.subject).to include('Welcome to Sangam')
        expect(mail.to).to eq(['user@example.com'])
        expect(mail.body.encoded).to include('John Doe')
      end
    end
  end
end
