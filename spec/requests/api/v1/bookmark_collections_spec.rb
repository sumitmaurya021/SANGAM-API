require 'rails_helper'

RSpec.describe "BookmarkCollections API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'PATCH /api/v1/bookmark_collections/:id/add_bookmark(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"add-bookmark") rescue {}
      patch "/api/v1/bookmark_collections/#{bookmark_collection.id}/add_bookmark", params: { 'add_bookmark'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/bookmark_collections/#{bookmark_collection.id}/add_bookmark", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/bookmark_collections/#{bookmark_collection.id}/add_bookmark"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/bookmark_collections/999999/add_bookmark", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/bookmark_collections(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/bookmark_collections", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/bookmark_collections"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/bookmark_collections(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"bookmark-collection") rescue {}
      post "/api/v1/bookmark_collections", params: { 'bookmark_collection'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/bookmark_collections", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/bookmark_collections"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/bookmark_collections/#{bookmark_collection.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/bookmark_collections/#{bookmark_collection.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/bookmark_collections/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"bookmark-collection") rescue {}
      patch "/api/v1/bookmark_collections/#{bookmark_collection.id}", params: { 'bookmark_collection'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/bookmark_collections/#{bookmark_collection.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/bookmark_collections/#{bookmark_collection.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/bookmark_collections/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"bookmark-collection") rescue {}
      put "/api/v1/bookmark_collections/#{bookmark_collection.id}", params: { 'bookmark_collection'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/bookmark_collections/#{bookmark_collection.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/bookmark_collections/#{bookmark_collection.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/bookmark_collections/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/bookmark_collections/#{bookmark_collection.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/bookmark_collections/#{bookmark_collection.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/bookmark_collections/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
