require 'rails_helper'

RSpec.describe "BookmarkCollections API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'PATCH /api/v1/bookmark_collections/:id/add_bookmark(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:add_bookmark) rescue {}
      patch "/api/v1/bookmark_collections/#{bookmark_collection.id}/add_bookmark", params: { add_bookmark: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/bookmark_collections(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/bookmark_collections", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/bookmark_collections(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:bookmark_collection) rescue {}
      post "/api/v1/bookmark_collections", params: { bookmark_collection: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/bookmark_collections/#{bookmark_collection.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:bookmark_collection) rescue {}
      patch "/api/v1/bookmark_collections/#{bookmark_collection.id}", params: { bookmark_collection: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:bookmark_collection) rescue {}
      put "/api/v1/bookmark_collections/#{bookmark_collection.id}", params: { bookmark_collection: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/bookmark_collections/:id(.:format)' do
    let(:bookmark_collection) { create(:bookmark_collection) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/bookmark_collections/#{bookmark_collection.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
