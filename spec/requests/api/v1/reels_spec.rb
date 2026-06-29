require 'rails_helper'

RSpec.describe "Reels API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/reels/:id/view(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:view) rescue {}
      post "/api/v1/reels/#{reel.id}/view", params: { view: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/reels(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/reels", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/reels(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel) rescue {}
      post "/api/v1/reels", params: { reel: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/reels/:id(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/reels/#{reel.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/reels/:id(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel) rescue {}
      patch "/api/v1/reels/#{reel.id}", params: { reel: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/reels/:id(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel) rescue {}
      put "/api/v1/reels/#{reel.id}", params: { reel: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/reels/:id(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/reels/#{reel.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
