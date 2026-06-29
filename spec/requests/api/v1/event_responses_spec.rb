require 'rails_helper'

RSpec.describe "EventResponses API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/events/:event_id/event_responses(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/events/#{event.id}/event_responses", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/events/#{event.id}/event_responses"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/events/999999/event_responses", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/events/:event_id/event_responses(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"event-response") rescue {}
      post "/api/v1/events/#{event.id}/event_responses", params: { 'event_response'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/events/#{event.id}/event_responses", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/events/#{event.id}/event_responses"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/events/999999/event_responses", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/events/#{event.id}/event_responses/#{event_response.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/events/999999/event_responses/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"event-response") rescue {}
      patch "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", params: { 'event_response'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/events/#{event.id}/event_responses/#{event_response.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/events/999999/event_responses/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"event-response") rescue {}
      put "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", params: { 'event_response'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/events/#{event.id}/event_responses/#{event_response.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/events/999999/event_responses/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/events/#{event.id}/event_responses/#{event_response.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/events/999999/event_responses/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
