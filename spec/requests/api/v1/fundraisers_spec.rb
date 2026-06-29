require 'rails_helper'

RSpec.describe "Fundraisers API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/fundraisers/:id/donate(.:format)' do
    let(:fundraiser) { create(:fundraiser) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:donate) rescue {}
      post "/api/v1/fundraisers/#{fundraiser.id}/donate", params: { donate: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/fundraisers(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/fundraisers", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/fundraisers(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:fundraiser) rescue {}
      post "/api/v1/fundraisers", params: { fundraiser: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/fundraisers/:id(.:format)' do
    let(:fundraiser) { create(:fundraiser) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/fundraisers/#{fundraiser.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/fundraisers/:id(.:format)' do
    let(:fundraiser) { create(:fundraiser) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:fundraiser) rescue {}
      patch "/api/v1/fundraisers/#{fundraiser.id}", params: { fundraiser: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/fundraisers/:id(.:format)' do
    let(:fundraiser) { create(:fundraiser) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:fundraiser) rescue {}
      put "/api/v1/fundraisers/#{fundraiser.id}", params: { fundraiser: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/fundraisers/:id(.:format)' do
    let(:fundraiser) { create(:fundraiser) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/fundraisers/#{fundraiser.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
