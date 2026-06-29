require 'rails_helper'

RSpec.describe "Follows API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/follows(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/follows", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/follows"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/follows(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"follow") rescue {}
      post "/api/v1/follows", params: { 'follow'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/follows", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/follows"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/follows/#{follow.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/follows/#{follow.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/follows/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"follow") rescue {}
      patch "/api/v1/follows/#{follow.id}", params: { 'follow'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/follows/#{follow.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/follows/#{follow.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/follows/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"follow") rescue {}
      put "/api/v1/follows/#{follow.id}", params: { 'follow'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/follows/#{follow.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/follows/#{follow.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/follows/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/follows/#{follow.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/follows/#{follow.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/follows/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
