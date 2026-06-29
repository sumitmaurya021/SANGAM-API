require 'rails_helper'

RSpec.describe "Profiles API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/profiles/friends_list(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/friends_list", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/profiles/search(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/search", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/profiles/toggle_dark_mode(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:toggle_dark_mode) rescue {}
      post "/api/v1/profiles/toggle_dark_mode", params: { toggle_dark_mode: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/profiles/:id/friends(.:format)' do
    let(:profile) { create(:profile) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}/friends", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/profiles/:id/followers(.:format)' do
    let(:profile) { create(:profile) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}/followers", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/profiles/:id/following(.:format)' do
    let(:profile) { create(:profile) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}/following", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/profiles/:id(.:format)' do
    let(:profile) { create(:profile) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


end
