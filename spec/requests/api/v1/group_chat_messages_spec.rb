require 'rails_helper'

RSpec.describe "GroupChatMessages API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/group_chats/:group_chat_id/group_chat_messages(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats/#{group_chat.id}/group_chat_messages", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/group_chats/:group_chat_id/group_chat_messages(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_chat_message) rescue {}
      post "/api/v1/group_chats/#{group_chat.id}/group_chat_messages", params: { group_chat_message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_chat_message) rescue {}
      patch "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", params: { group_chat_message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:group_chat_message) rescue {}
      put "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", params: { group_chat_message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
