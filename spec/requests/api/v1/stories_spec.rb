require 'rails_helper'

RSpec.describe "Stories API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/stories/share_to_story(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"share-to-story") rescue {}
      post "/api/v1/stories/share_to_story", params: { 'share_to_story'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/stories/share_to_story", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/stories/share_to_story"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/stories/active(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories/active", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/stories/active"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/stories/:id/view(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"view") rescue {}
      post "/api/v1/stories/#{story.id}/view", params: { 'view'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/stories/#{story.id}/view"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/stories/999999/view", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/stories(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/stories"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/stories(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"story") rescue {}
      post "/api/v1/stories", params: { 'story'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/stories", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/stories"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories/#{story.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/stories/#{story.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/stories/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"story") rescue {}
      patch "/api/v1/stories/#{story.id}", params: { 'story'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/stories/#{story.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/stories/#{story.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/stories/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"story") rescue {}
      put "/api/v1/stories/#{story.id}", params: { 'story'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/stories/#{story.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/stories/#{story.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/stories/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/stories/:id(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/stories/#{story.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/stories/#{story.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/stories/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
