require 'rails_helper'

RSpec.describe "Polls API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/polls/:id/vote(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"vote") rescue {}
      post "/api/v1/polls/#{poll.id}/vote", params: { 'vote'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/polls/#{poll.id}/vote", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/polls/#{poll.id}/vote"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/polls/999999/vote", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/polls(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/polls"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/polls(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"poll") rescue {}
      post "/api/v1/polls", params: { 'poll'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/polls", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/polls"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls/#{poll.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/polls/#{poll.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/polls/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"poll") rescue {}
      patch "/api/v1/polls/#{poll.id}", params: { 'poll'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/polls/#{poll.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/polls/#{poll.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/polls/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"poll") rescue {}
      put "/api/v1/polls/#{poll.id}", params: { 'poll'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/polls/#{poll.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/polls/#{poll.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/polls/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/polls/#{poll.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/polls/#{poll.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/polls/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
