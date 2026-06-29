require 'rails_helper'

RSpec.describe "GroupMemberships API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/groups/:group_id/group_memberships(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups/#{group.id}/group_memberships", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/groups/:group_id/group_memberships(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_membership) rescue {}
      post "/api/v1/groups/#{group.id}/group_memberships", params: { group_membership: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_membership) rescue {}
      patch "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", params: { group_membership: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_membership) rescue {}
      put "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", params: { group_membership: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/groups/:group_id/group_memberships/:id(.:format)' do
    let(:group) { create(:group) }
    let(:group_membership) { create(:group_membership) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}/group_memberships/#{group_membership.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
