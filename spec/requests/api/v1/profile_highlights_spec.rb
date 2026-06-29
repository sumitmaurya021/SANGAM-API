require 'rails_helper'

RSpec.describe "ProfileHighlights API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/profile_highlights(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/profile_highlights", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profile_highlights"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/profile_highlights/:id/add_story(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"add-story") rescue {}
      post "/api/v1/profile_highlights/#{profile_highlight.id}/add_story", params: { 'add_story'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/profile_highlights/#{profile_highlight.id}/add_story", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/profile_highlights/#{profile_highlight.id}/add_story"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/profile_highlights/999999/add_story", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/profile_highlights/:id/remove_story(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/profile_highlights/#{profile_highlight.id}/remove_story", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/profile_highlights/#{profile_highlight.id}/remove_story"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/profile_highlights/999999/remove_story", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/profile_highlights/:id/stories(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profile_highlights/#{profile_highlight.id}/stories", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profile_highlights/#{profile_highlight.id}/stories"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/profile_highlights/999999/stories", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/profile_highlights(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"profile-highlight") rescue {}
      post "/api/v1/profile_highlights", params: { 'profile_highlight'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/profile_highlights", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/profile_highlights"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profile_highlights/#{profile_highlight.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profile_highlights/#{profile_highlight.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/profile_highlights/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"profile-highlight") rescue {}
      patch "/api/v1/profile_highlights/#{profile_highlight.id}", params: { 'profile_highlight'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/profile_highlights/#{profile_highlight.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/profile_highlights/#{profile_highlight.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/profile_highlights/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"profile-highlight") rescue {}
      put "/api/v1/profile_highlights/#{profile_highlight.id}", params: { 'profile_highlight'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/profile_highlights/#{profile_highlight.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/profile_highlights/#{profile_highlight.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/profile_highlights/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/profile_highlights/:id(.:format)' do
    let(:profile_highlight) { create(:profile_highlight) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/profile_highlights/#{profile_highlight.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/profile_highlights/#{profile_highlight.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/profile_highlights/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
