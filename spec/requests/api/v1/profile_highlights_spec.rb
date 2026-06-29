require 'rails_helper'

RSpec.describe "ProfileHighlights API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/profile_highlights(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/profile_highlights", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/profile_highlights/:id/add_story(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:add_story) rescue {}
      post "/api/v1/profile_highlights/#{profile_highlight.id}/add_story", params: { add_story: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/profile_highlights/:id/remove_story(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/profile_highlights/#{profile_highlight.id}/remove_story", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


  describe 'GET /api/v1/profile_highlights/:id/stories(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profile_highlights/#{profile_highlight.id}/stories", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/profile_highlights(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:profile_highlight) rescue {}
      post "/api/v1/profile_highlights", params: { profile_highlight: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profile_highlights/#{profile_highlight.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:profile_highlight) rescue {}
      patch "/api/v1/profile_highlights/#{profile_highlight.id}", params: { profile_highlight: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:profile_highlight) rescue {}
      put "/api/v1/profile_highlights/#{profile_highlight.id}", params: { profile_highlight: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/profile_highlights/#{profile_highlight.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
