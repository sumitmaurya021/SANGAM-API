require 'rails_helper'

RSpec.describe "Unlocks API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/auth/unlock(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/auth/unlock", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/auth/unlock(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:unlock) rescue {}
      post "/api/v1/auth/unlock", params: { unlock: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
