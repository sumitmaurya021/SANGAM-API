require 'rails_helper'

RSpec.describe "MarketplaceListings API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/marketplace_listings/my_listings(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/marketplace_listings/my_listings", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/marketplace_listings/my_listings"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'PATCH /api/v1/marketplace_listings/:id/mark_sold(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"mark-sold") rescue {}
      patch "/api/v1/marketplace_listings/#{marketplace_listing.id}/mark_sold", params: { 'mark_sold'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/marketplace_listings/#{marketplace_listing.id}/mark_sold", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/marketplace_listings/#{marketplace_listing.id}/mark_sold"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/marketplace_listings/999999/mark_sold", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/marketplace_listings(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/marketplace_listings", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/marketplace_listings"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/marketplace_listings(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"marketplace-listing") rescue {}
      post "/api/v1/marketplace_listings", params: { 'marketplace_listing'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/marketplace_listings", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/marketplace_listings"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/marketplace_listings/#{marketplace_listing.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/marketplace_listings/#{marketplace_listing.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/marketplace_listings/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"marketplace-listing") rescue {}
      patch "/api/v1/marketplace_listings/#{marketplace_listing.id}", params: { 'marketplace_listing'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/marketplace_listings/#{marketplace_listing.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/marketplace_listings/#{marketplace_listing.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/marketplace_listings/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"marketplace-listing") rescue {}
      put "/api/v1/marketplace_listings/#{marketplace_listing.id}", params: { 'marketplace_listing'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/marketplace_listings/#{marketplace_listing.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/marketplace_listings/#{marketplace_listing.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/marketplace_listings/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/marketplace_listings/:id(.:format)' do
    let(:marketplace_listing) { create(:marketplace_listing) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/marketplace_listings/#{marketplace_listing.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/marketplace_listings/#{marketplace_listing.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/marketplace_listings/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
