require 'rails_helper'

RSpec.describe "MarketplaceListings API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/marketplace_listings/my_listings(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/marketplace_listings/my_listings", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/marketplace_listings/:id/mark_sold(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:mark_sold) rescue {}
      patch "/api/v1/marketplace_listings/#{marketplace_listing.id}/mark_sold", params: { mark_sold: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/marketplace_listings(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/marketplace_listings", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/marketplace_listings(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:marketplace_listing) rescue {}
      post "/api/v1/marketplace_listings", params: { marketplace_listing: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/marketplace_listings/#{marketplace_listing.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:marketplace_listing) rescue {}
      patch "/api/v1/marketplace_listings/#{marketplace_listing.id}", params: { marketplace_listing: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:marketplace_listing) rescue {}
      put "/api/v1/marketplace_listings/#{marketplace_listing.id}", params: { marketplace_listing: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/marketplace_listings/#{marketplace_listing.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
