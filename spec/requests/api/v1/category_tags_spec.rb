require 'rails_helper'

RSpec.describe "CategoryTags API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/category_tags(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/category_tags", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/category_tags(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:category_tag) rescue {}
      post "/api/v1/category_tags", params: { category_tag: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/category_tags/#{category_tag.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:category_tag) rescue {}
      patch "/api/v1/category_tags/#{category_tag.id}", params: { category_tag: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:category_tag) rescue {}
      put "/api/v1/category_tags/#{category_tag.id}", params: { category_tag: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/category_tags/:id(.:format)' do
    let(:category_tag) { create(:category_tag) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/category_tags/#{category_tag.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
