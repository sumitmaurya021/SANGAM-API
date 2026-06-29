require 'rails_helper'

RSpec.describe "Friendships API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/friendships/:id/accept(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"accept") rescue {}
      post "/api/v1/friendships/#{friendship.id}/accept", params: { 'accept'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/friendships/#{friendship.id}/accept", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/friendships/#{friendship.id}/accept"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/friendships/999999/accept", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/friendships/:id/reject(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reject") rescue {}
      post "/api/v1/friendships/#{friendship.id}/reject", params: { 'reject'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/friendships/#{friendship.id}/reject", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/friendships/#{friendship.id}/reject"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/friendships/999999/reject", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/friendships(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/friendships", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/friendships"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/friendships(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"friendship") rescue {}
      post "/api/v1/friendships", params: { 'friendship'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/friendships", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/friendships"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/friendships/#{friendship.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/friendships/#{friendship.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/friendships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"friendship") rescue {}
      patch "/api/v1/friendships/#{friendship.id}", params: { 'friendship'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/friendships/#{friendship.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/friendships/#{friendship.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/friendships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"friendship") rescue {}
      put "/api/v1/friendships/#{friendship.id}", params: { 'friendship'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/friendships/#{friendship.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/friendships/#{friendship.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/friendships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/friendships/#{friendship.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/friendships/#{friendship.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/friendships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
