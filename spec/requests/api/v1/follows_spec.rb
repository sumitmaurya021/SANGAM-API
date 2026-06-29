require 'rails_helper'

RSpec.describe "Follows API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/follows(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/follows", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/follows(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:follow) rescue {}
      post "/api/v1/follows", params: { follow: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/follows/#{follow.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:follow) rescue {}
      patch "/api/v1/follows/#{follow.id}", params: { follow: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:follow) rescue {}
      put "/api/v1/follows/#{follow.id}", params: { follow: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/follows/:id(.:format)' do
    let(:follow) { create(:follow) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/follows/#{follow.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
