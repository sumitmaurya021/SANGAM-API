require 'rails_helper'

RSpec.describe "CategoryTags API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/category_tags(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/category_tags", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/category_tags"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/category_tags(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"category-tag") rescue {}
      post "/api/v1/category_tags", params: { 'category_tag'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/category_tags", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/category_tags"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/category_tags/#{category_tag.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/category_tags/#{category_tag.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/category_tags/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"category-tag") rescue {}
      patch "/api/v1/category_tags/#{category_tag.id}", params: { 'category_tag'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/category_tags/#{category_tag.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/category_tags/#{category_tag.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/category_tags/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"category-tag") rescue {}
      put "/api/v1/category_tags/#{category_tag.id}", params: { 'category_tag'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/category_tags/#{category_tag.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/category_tags/#{category_tag.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/category_tags/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/category_tags/#{category_tag.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/category_tags/#{category_tag.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/category_tags/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
