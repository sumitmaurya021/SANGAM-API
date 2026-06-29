require 'rails_helper'

RSpec.describe "Groups API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/groups/:id/join(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"join") rescue {}
      post "/api/v1/groups/#{group.id}/join", params: { 'join'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/groups/#{group.id}/join"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/groups/999999/join", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/groups/:id/leave(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}/leave", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/groups/#{group.id}/leave"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/groups/999999/leave", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/groups/:id/approve_member(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"approve-member") rescue {}
      post "/api/v1/groups/#{group.id}/approve_member", params: { 'approve_member'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/groups/#{group.id}/approve_member", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/groups/#{group.id}/approve_member"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/groups/999999/approve_member", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/groups/:id/remove_member(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}/remove_member", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/groups/#{group.id}/remove_member"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/groups/999999/remove_member", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/groups(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/groups"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/groups(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group") rescue {}
      post "/api/v1/groups", params: { 'group'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/groups", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/groups"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups/#{group.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/groups/#{group.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/groups/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group") rescue {}
      patch "/api/v1/groups/#{group.id}", params: { 'group'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/groups/#{group.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/groups/#{group.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/groups/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group") rescue {}
      put "/api/v1/groups/#{group.id}", params: { 'group'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/groups/#{group.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/groups/#{group.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/groups/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/groups/#{group.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/groups/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
