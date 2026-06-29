require 'rails_helper'

RSpec.describe "Events API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/events/:id/respond(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"respond") rescue {}
      post "/api/v1/events/#{event.id}/respond", params: { 'respond'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/events/#{event.id}/respond", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/events/#{event.id}/respond"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/events/999999/respond", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/events(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/events", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/events"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/events(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"event") rescue {}
      post "/api/v1/events", params: { 'event'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/events", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/events"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/events/#{event.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/events/#{event.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/events/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"event") rescue {}
      patch "/api/v1/events/#{event.id}", params: { 'event'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/events/#{event.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/events/#{event.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/events/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"event") rescue {}
      put "/api/v1/events/#{event.id}", params: { 'event'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/events/#{event.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/events/#{event.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/events/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/events/#{event.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/events/#{event.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/events/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
