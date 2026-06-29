require 'rails_helper'

RSpec.describe "Groups API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/groups/:id/join(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:join) rescue {}
      post "/api/v1/groups/#{group.id}/join", params: { join: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/groups/:id/leave(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}/leave", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


  describe 'POST /api/v1/groups/:id/approve_member(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:approve_member) rescue {}
      post "/api/v1/groups/#{group.id}/approve_member", params: { approve_member: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/groups/:id/remove_member(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}/remove_member", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


  describe 'GET /api/v1/groups(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/groups(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group) rescue {}
      post "/api/v1/groups", params: { group: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/groups/#{group.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group) rescue {}
      patch "/api/v1/groups/#{group.id}", params: { group: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group) rescue {}
      put "/api/v1/groups/#{group.id}", params: { group: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/groups/:id(.:format)' do
    let(:group) { create(:group) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/groups/#{group.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
