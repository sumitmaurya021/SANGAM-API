require 'rails_helper'

RSpec.describe "Events API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/events/:id/respond(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:respond) rescue {}
      post "/api/v1/events/#{event.id}/respond", params: { respond: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/events(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/events", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/events(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:event) rescue {}
      post "/api/v1/events", params: { event: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/events/#{event.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:event) rescue {}
      patch "/api/v1/events/#{event.id}", params: { event: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:event) rescue {}
      put "/api/v1/events/#{event.id}", params: { event: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/events/:id(.:format)' do
    let(:event) { create(:event) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/events/#{event.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
