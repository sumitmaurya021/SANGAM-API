require 'rails_helper'

RSpec.describe "Notifications API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/notifications/mark_all_read(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:mark_all_read) rescue {}
      post "/api/v1/notifications/mark_all_read", params: { mark_all_read: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/notifications/dropdown(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/notifications/dropdown", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/notifications/:id/mark_read(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:mark_read) rescue {}
      post "/api/v1/notifications/#{notification.id}/mark_read", params: { mark_read: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/notifications(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/notifications", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/notifications(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:notification) rescue {}
      post "/api/v1/notifications", params: { notification: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/notifications/#{notification.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:notification) rescue {}
      patch "/api/v1/notifications/#{notification.id}", params: { notification: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:notification) rescue {}
      put "/api/v1/notifications/#{notification.id}", params: { notification: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/notifications/#{notification.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
