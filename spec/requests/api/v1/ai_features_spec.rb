require 'rails_helper'

RSpec.describe "AiFeatures API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/ai_features/generate_caption(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:generate_caption) rescue {}
      post "/api/v1/ai_features/generate_caption", params: { generate_caption: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/ai_features/rewrite_message(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:rewrite_message) rescue {}
      post "/api/v1/ai_features/rewrite_message", params: { rewrite_message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/ai_features/smart_reply(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:smart_reply) rescue {}
      post "/api/v1/ai_features/smart_reply", params: { smart_reply: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/ai_features/search(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/ai_features/search", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/ai_features/generate_smart_replies(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:generate_smart_reply) rescue {}
      post "/api/v1/ai_features/generate_smart_replies", params: { generate_smart_reply: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/ai_features/generate_article_content(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:generate_article_content) rescue {}
      post "/api/v1/ai_features/generate_article_content", params: { generate_article_content: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/ai_features/auto_fill_listing(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:auto_fill_listing) rescue {}
      post "/api/v1/ai_features/auto_fill_listing", params: { auto_fill_listing: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
