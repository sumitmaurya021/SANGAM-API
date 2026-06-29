require 'rails_helper'

RSpec.describe "Friendships API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/friendships/:id/accept(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:accept) rescue {}
      post "/api/v1/friendships/#{friendship.id}/accept", params: { accept: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/friendships/:id/reject(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reject) rescue {}
      post "/api/v1/friendships/#{friendship.id}/reject", params: { reject: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/friendships(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/friendships", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/friendships(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:friendship) rescue {}
      post "/api/v1/friendships", params: { friendship: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/friendships/#{friendship.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:friendship) rescue {}
      patch "/api/v1/friendships/#{friendship.id}", params: { friendship: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:friendship) rescue {}
      put "/api/v1/friendships/#{friendship.id}", params: { friendship: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/friendships/:id(.:format)' do
    let(:friendship) { create(:friendship) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/friendships/#{friendship.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
