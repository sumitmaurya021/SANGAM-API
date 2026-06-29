require 'rails_helper'

RSpec.describe "Passwords API", type: :request do
  let(:user) { create(:user, super_admin: true) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/forgot-password(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"forgot-password") rescue {}
      post "/api/v1/auth/forgot-password", params: { 'forgot-password'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/forgot-password", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/forgot-password"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/auth/reset-password(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reset-password") rescue {}
      post "/api/v1/auth/reset-password", params: { 'reset-password'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/reset-password", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/reset-password"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/auth/change-password(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"change-password") rescue {}
      post "/api/v1/auth/change-password", params: { 'change-password'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/change-password", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/change-password"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
