require 'rails_helper'

RSpec.describe "GroupChats API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/group_chats/:id/add_member(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:add_member) rescue {}
      post "/api/v1/group_chats/#{group_chat.id}/add_member", params: { add_member: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/group_chats/:id/remove_member(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}/remove_member", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


  describe 'DELETE /api/v1/group_chats/:id/leave(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}/leave", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


  describe 'GET /api/v1/group_chats(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/group_chats(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_chat) rescue {}
      post "/api/v1/group_chats", params: { group_chat: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats/#{group_chat.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_chat) rescue {}
      patch "/api/v1/group_chats/#{group_chat.id}", params: { group_chat: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_chat) rescue {}
      put "/api/v1/group_chats/#{group_chat.id}", params: { group_chat: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
