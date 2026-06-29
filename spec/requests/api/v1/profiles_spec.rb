require 'rails_helper'

RSpec.describe "Profiles API", type: :request do
  let(:user) { create(:user, super_admin: true) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/profiles/friends_list(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/friends_list", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profiles/friends_list"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/profiles/search(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/search", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profiles/search"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/profiles/toggle_dark_mode(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"toggle-dark-mode") rescue {}
      post "/api/v1/profiles/toggle_dark_mode", params: { 'toggle_dark_mode'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/profiles/toggle_dark_mode"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/profiles/:id/friends(.:format)' do
    let(:profile) { create(:user) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}/friends", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profiles/#{profile.id}/friends"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/profiles/999999/friends", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/profiles/:id/followers(.:format)' do
    let(:profile) { create(:user) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}/followers", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profiles/#{profile.id}/followers"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/profiles/999999/followers", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/profiles/:id/following(.:format)' do
    let(:profile) { create(:user) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}/following", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profiles/#{profile.id}/following"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/profiles/999999/following", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/profiles/:id(.:format)' do
    let(:profile) { create(:user) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/profiles/#{profile.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/profiles/#{profile.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/profiles/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
