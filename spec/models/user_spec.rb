require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:articles).dependent(:destroy) }
    it { should have_many(:remember_tokens).dependent(:destroy) }
  end

  describe 'password change callbacks' do
    it 'revokes all remember tokens when password is changed' do
      user = create(:user)
      create_list(:remember_token, 3, user: user)

      expect(user.remember_tokens.count).to eq(3)

      user.update(password: 'new_secure_password', password_confirmation: 'new_secure_password')

      expect(user.remember_tokens.count).to eq(0)
    end
  end

  describe 'OTP functionality' do
    let(:user) { create(:user) }

    it 'generates a secure hashed OTP and resets attempts' do
      user.update(otp_attempts: 3)
      raw_otp = user.generate_otp!

      expect(raw_otp).to match(/\A\d{6}\z/)
      expect(user.otp_secret).to_not be_nil
      expect(user.otp_secret).to_not eq(raw_otp) # Should be bcrypt hash
      expect(user.otp_expires_at).to be > Time.current
      expect(user.otp_attempts).to eq(0)
    end

    it 'validates correct OTP' do
      raw_otp = user.generate_otp!
      expect(user.valid_otp?(raw_otp)).to be true
    end

    it 'rejects expired OTP' do
      raw_otp = user.generate_otp!
      user.update(otp_expires_at: 1.second.ago)
      expect(user.valid_otp?(raw_otp)).to be false
    end

    it 'increments attempts and locks after 5 attempts' do
      raw_otp = user.generate_otp!
      
      # 4 invalid attempts
      4.times do
        expect(user.valid_otp?('000000')).to be false
      end
      
      user.reload
      expect(user.otp_attempts).to eq(4)

      # 5th attempt is invalid
      expect(user.valid_otp?('000000')).to be false
      user.reload
      expect(user.otp_attempts).to eq(5)

      # Even if correct OTP is passed now, it should reject because attempts reached limit
      expect(user.valid_otp?(raw_otp)).to be false
    end

    it 'clears OTP details and resets attempts' do
      user.generate_otp!
      user.update(otp_attempts: 2)

      user.clear_otp!
      expect(user.otp_secret).to be_nil
      expect(user.otp_expires_at).to be_nil
      expect(user.otp_attempts).to eq(0)
    end
  end
end
