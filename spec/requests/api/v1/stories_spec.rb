require 'rails_helper'

RSpec.describe "Stories API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/stories/share_to_story(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:share_to_story) rescue {}
      post "/api/v1/stories/share_to_story", params: { share_to_story: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/stories/active(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories/active", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/stories/:id/view(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:view) rescue {}
      post "/api/v1/stories/#{story.id}/view", params: { view: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/stories(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/stories(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:story) rescue {}
      post "/api/v1/stories", params: { story: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories/#{story.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:story) rescue {}
      patch "/api/v1/stories/#{story.id}", params: { story: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:story) rescue {}
      put "/api/v1/stories/#{story.id}", params: { story: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/stories/#{story.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
