require 'rails_helper'

RSpec.describe "Dashboard API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/admin/dashboard(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/admin/dashboard/users(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard/users", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/admin/dashboard/posts(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard/posts", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'GET /api/v1/admin/dashboard/users/:id(.:format)' do
    let(:user) { create(:user) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


end
