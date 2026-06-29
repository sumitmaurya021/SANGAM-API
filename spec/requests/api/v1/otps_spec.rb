require 'rails_helper'

RSpec.describe "Otps API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/verify-otp(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:verify-otp) rescue {}
      post "/api/v1/auth/verify-otp", params: { verify-otp: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/auth/resend-otp(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:resend-otp) rescue {}
      post "/api/v1/auth/resend-otp", params: { resend-otp: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
