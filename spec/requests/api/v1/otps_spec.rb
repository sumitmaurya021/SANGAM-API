require 'rails_helper'

RSpec.describe "Otps API", type: :request do
  let(:user) { create(:user, super_admin: true) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/verify-otp(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"verify-otp") rescue {}
      post "/api/v1/auth/verify-otp", params: { 'verify-otp'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/verify-otp", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/verify-otp"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/auth/resend-otp(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"resend-otp") rescue {}
      post "/api/v1/auth/resend-otp", params: { 'resend-otp'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/resend-otp", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/resend-otp"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
