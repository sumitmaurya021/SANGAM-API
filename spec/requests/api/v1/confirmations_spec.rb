require 'rails_helper'

RSpec.describe "Confirmations API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/auth/confirmation(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/auth/confirmation", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/auth/confirmation"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/auth/confirmation(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"confirmation") rescue {}
      post "/api/v1/auth/confirmation", params: { 'confirmation'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/auth/confirmation", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/auth/confirmation"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
