require 'rails_helper'

RSpec.describe 'Authentication API', type: :request do
  describe 'POST /api/v1/auth/signup' do
    let(:valid_params) do
      {
        user: {
          name: 'John Doe',
          email: 'john@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    it 'initiates signup and sends email OTP' do
      expect(OtpMailer).to receive(:otp_email).and_call_original

      expect {
        post '/api/v1/auth/signup', params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['success']).to be true
      expect(json['message']).to include('Registration initiated')
      expect(json['data']['user_id']).to_not be_nil

      user = User.last
      expect(user.verified).to be false
      expect(user.otp_secret).to_not be_nil
    end

    it 'fails on invalid params' do
      post '/api/v1/auth/signup', params: { user: { email: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['success']).to be false
    end
  end

  describe 'POST /api/v1/auth/login' do
    let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

    it 'requires OTP when logging in normally' do
      expect(OtpMailer).to receive(:otp_email).and_call_original

      post '/api/v1/auth/login', params: { email: user.email, password: 'password123' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['require_otp']).to be true
      expect(json['data']['user_id']).to eq(user.id)
    end

    it 'skips OTP verification and logs in directly if a valid remember_token is provided' do
      raw_remember_token = SecureRandom.hex(32)
      token_hash = Digest::SHA256.hexdigest(raw_remember_token)
      create(:remember_token, user: user, token_hash: token_hash)

      post '/api/v1/auth/login', params: { email: user.email, password: 'password123', remember_token: raw_remember_token }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['token']).to_not be_nil
      expect(json['data']['user']['id']).to eq(user.id)
    end

    it 'requires OTP if remember_token is expired' do
      raw_remember_token = SecureRandom.hex(32)
      token_hash = Digest::SHA256.hexdigest(raw_remember_token)
      create(:remember_token, user: user, token_hash: token_hash, expires_at: 1.day.ago)

      post '/api/v1/auth/login', params: { email: user.email, password: 'password123', remember_token: raw_remember_token }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['require_otp']).to be true
    end

    it 'returns unauthorized for invalid password' do
      post '/api/v1/auth/login', params: { email: user.email, password: 'wrongpassword' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /api/v1/auth/verify-otp' do
    let!(:user) { create(:user, verified: false) }
    let!(:raw_otp) { user.generate_otp! }

    it 'activates user and generates JWT + remember_token if remember_me is true' do
      post '/api/v1/auth/verify-otp', params: { user_id: user.id, otp: raw_otp, remember_me: true }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['token']).to_not be_nil
      expect(json['data']['remember_token']).to_not be_nil
      expect(user.reload.verified).to be true
      expect(user.confirmed_at).to_not be_nil
    end

    it 'locks/rejects after too many failed attempts' do
      5.times do
        post '/api/v1/auth/verify-otp', params: { user_id: user.id, otp: '000000' }
      end
      expect(response).to have_http_status(:unauthorized)
      
      # 6th attempt should return rate limit lock message
      post '/api/v1/auth/verify-otp', params: { user_id: user.id, otp: raw_otp }
      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(response.body)
      expect(json['message']).to include('Too many failed attempts')
    end
  end

  describe 'POST /api/v1/auth/resend-otp' do
    let!(:user) { create(:user) }

    it 'generates a new OTP and resends email' do
      expect(OtpMailer).to receive(:otp_email).and_call_original

      post '/api/v1/auth/resend-otp', params: { user_id: user.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/v1/auth/logout' do
    let!(:user) { create(:user) }
    let!(:token) { JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base.to_s) }

    it 'revokes all remember tokens' do
      create_list(:remember_token, 3, user: user)

      delete '/api/v1/auth/logout', headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      expect(user.remember_tokens.count).to eq(0)
    end
  end

  describe 'Password Management' do
    let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

    it 'sends OTP for forgot password' do
      expect(OtpMailer).to receive(:otp_email).and_call_original
      post '/api/v1/auth/forgot-password', params: { email: user.email }
      expect(response).to have_http_status(:ok)
    end

    it 'resets password via OTP' do
      raw_otp = user.generate_otp!
      post '/api/v1/auth/reset-password', params: {
        user_id: user.id,
        otp: raw_otp,
        password: 'newpassword123',
        password_confirmation: 'newpassword123'
      }
      expect(response).to have_http_status(:ok)
      expect(user.reload.authenticate('newpassword123')).to be_truthy
    end

    it 'changes password when authenticated and invalidates remember tokens' do
      token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base.to_s)
      create_list(:remember_token, 2, user: user)

      post '/api/v1/auth/change-password', params: {
        current_password: 'password123',
        new_password: 'supernewpassword',
        new_password_confirmation: 'supernewpassword'
      }, headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      expect(user.remember_tokens.count).to eq(0)
    end
  end

  describe 'TOTP / 2FA Settings' do
    let!(:user) { create(:user) }
    let!(:token) { JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base.to_s) }

    it 'initiates TOTP configuration' do
      post '/api/v1/auth/totp/enable', headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['otp_secret']).to_not be_nil
    end

    it 'enables TOTP after validation' do
      user.update(otp_secret: ROTP::Base32.random)
      totp = ROTP::TOTP.new(user.otp_secret, issuer: 'Sangam')
      code = totp.now

      post '/api/v1/auth/totp/confirm', params: { code: code }, headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      expect(user.reload.otp_enabled).to be true
    end
  end
end
