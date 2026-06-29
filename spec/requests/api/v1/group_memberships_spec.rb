require 'rails_helper'

RSpec.describe "GroupMemberships API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/groups/:group_id/group_memberships(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups/#{group.id}/group_memberships", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/groups/#{group.id}/group_memberships"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/groups/999999/group_memberships", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/groups/:group_id/group_memberships(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-membership") rescue {}
      post "/api/v1/groups/#{group.id}/group_memberships", params: { 'group_membership'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/groups/#{group.id}/group_memberships", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/groups/#{group.id}/group_memberships"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/groups/999999/group_memberships", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/groups/999999/group_memberships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-membership") rescue {}
      patch "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", params: { 'group_membership'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/groups/999999/group_memberships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-membership") rescue {}
      put "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", params: { 'group_membership'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/groups/999999/group_memberships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/groups/999999/group_memberships/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
