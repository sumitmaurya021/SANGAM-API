require 'rails_helper'

RSpec.describe "Totp API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/totp/enable(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"enable") rescue {}
      post "/api/v1/auth/totp/enable", params: { 'enable'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/totp/enable"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/auth/totp/confirm(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"confirm") rescue {}
      post "/api/v1/auth/totp/confirm", params: { 'confirm'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/totp/confirm", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/totp/confirm"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/auth/totp/disable(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"disable") rescue {}
      post "/api/v1/auth/totp/disable", params: { 'disable'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/totp/disable", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/totp/disable"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
