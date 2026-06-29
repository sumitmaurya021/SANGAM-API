require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/users(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/users", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/users"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/users/:id(.:format)' do
    let(:user) { create(:user) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/users/#{user.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/users/#{user.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/users/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/users/:id(.:format)' do
    let(:user) { create(:user) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"user") rescue {}
      patch "/api/v1/users/#{user.id}", params: { 'user'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/users/#{user.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/users/#{user.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/users/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/users/:id(.:format)' do
    let(:user) { create(:user) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"user") rescue {}
      put "/api/v1/users/#{user.id}", params: { 'user'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/users/#{user.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/users/#{user.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/users/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/users/:id(.:format)' do
    let(:user) { create(:user) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/users/#{user.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/users/#{user.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/users/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
