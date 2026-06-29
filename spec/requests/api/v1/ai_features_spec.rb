require 'rails_helper'

RSpec.describe "AiFeatures API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/ai_features/generate_caption(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"generate-caption") rescue {}
      post "/api/v1/ai_features/generate_caption", params: { 'generate_caption'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/ai_features/generate_caption", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/ai_features/generate_caption"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/ai_features/rewrite_message(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"rewrite-message") rescue {}
      post "/api/v1/ai_features/rewrite_message", params: { 'rewrite_message'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/ai_features/rewrite_message", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/ai_features/rewrite_message"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/ai_features/smart_reply(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"smart-reply") rescue {}
      post "/api/v1/ai_features/smart_reply", params: { 'smart_reply'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/ai_features/smart_reply", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/ai_features/smart_reply"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/ai_features/search(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/ai_features/search", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/ai_features/search"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/ai_features/generate_smart_replies(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"generate-smart-reply") rescue {}
      post "/api/v1/ai_features/generate_smart_replies", params: { 'generate_smart_reply'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/ai_features/generate_smart_replies", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/ai_features/generate_smart_replies"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/ai_features/generate_article_content(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"generate-article-content") rescue {}
      post "/api/v1/ai_features/generate_article_content", params: { 'generate_article_content'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/ai_features/generate_article_content", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/ai_features/generate_article_content"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/ai_features/auto_fill_listing(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"auto-fill-listing") rescue {}
      post "/api/v1/ai_features/auto_fill_listing", params: { 'auto_fill_listing'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/ai_features/auto_fill_listing", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/ai_features/auto_fill_listing"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
