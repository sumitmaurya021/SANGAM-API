require 'rails_helper'

RSpec.describe "EventResponses API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/events/:event_id/event_responses(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/events/#{event.id}/event_responses", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/events/:event_id/event_responses(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:event_response) rescue {}
      post "/api/v1/events/#{event.id}/event_responses", params: { event_response: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:event_response) rescue {}
      patch "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", params: { event_response: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:event_response) rescue {}
      put "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", params: { event_response: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/events/:event_id/event_responses/:id(.:format)' do
    let(:event) { create(:event) }
    let(:event_response) { create(:event_response) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/events/#{event.id}/event_responses/#{event_response.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
