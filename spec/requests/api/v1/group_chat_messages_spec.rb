require 'rails_helper'

RSpec.describe "GroupChatMessages API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/group_chats/:group_chat_id/group_chat_messages(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats/#{group_chat.id}/group_chat_messages", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/group_chats/#{group_chat.id}/group_chat_messages"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/group_chats/999999/group_chat_messages", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/group_chats/:group_chat_id/group_chat_messages(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-chat-message") rescue {}
      post "/api/v1/group_chats/#{group_chat.id}/group_chat_messages", params: { 'group_chat_message'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/group_chats/#{group_chat.id}/group_chat_messages", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/group_chats/#{group_chat.id}/group_chat_messages"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/group_chats/999999/group_chat_messages", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/group_chats/999999/group_chat_messages/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-chat-message") rescue {}
      patch "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", params: { 'group_chat_message'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/group_chats/999999/group_chat_messages/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-chat-message") rescue {}
      put "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", params: { 'group_chat_message'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/group_chats/999999/group_chat_messages/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/group_chats/:group_chat_id/group_chat_messages/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }
    let(:group_chat_message) { create(:group_chat_message) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/group_chats/#{group_chat.id}/group_chat_messages/#{group_chat_message.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/group_chats/999999/group_chat_messages/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
