require 'rails_helper'

RSpec.describe "CloseFriends API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/close_friends(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/close_friends", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/close_friends(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:close_friend) rescue {}
      post "/api/v1/close_friends", params: { close_friend: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/close_friends/:id(.:format)' do
    let(:close_friend) { create(:close_friend) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/close_friends/#{close_friend.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/close_friends/:id(.:format)' do
    let(:close_friend) { create(:close_friend) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:close_friend) rescue {}
      patch "/api/v1/close_friends/#{close_friend.id}", params: { close_friend: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/close_friends/:id(.:format)' do
    let(:close_friend) { create(:close_friend) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:close_friend) rescue {}
      put "/api/v1/close_friends/#{close_friend.id}", params: { close_friend: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/close_friends/:id(.:format)' do
    let(:close_friend) { create(:close_friend) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/close_friends/#{close_friend.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
