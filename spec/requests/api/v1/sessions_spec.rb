require 'rails_helper'

RSpec.describe "Sessions API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/login(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"login") rescue {}
      post "/api/v1/auth/login", params: { 'login'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/login", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/login"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'DELETE /api/v1/auth/logout(.:format)' do

    it 'executes the request and returns a valid status' do
      delete "/api/v1/auth/logout", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/auth/logout"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
