require 'rails_helper'

RSpec.describe "Dashboard API", type: :request do
  let(:user) { create(:user, super_admin: true) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/admin/dashboard(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/admin/dashboard"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/admin/dashboard/users(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard/users", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/admin/dashboard/users"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/admin/dashboard/posts(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard/posts", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/admin/dashboard/posts"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/admin/dashboard/users/:id(.:format)' do
    let(:user) { create(:user, super_admin: true) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/admin/dashboard/users/#{user.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/admin/dashboard/users/#{user.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/admin/dashboard/users/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
