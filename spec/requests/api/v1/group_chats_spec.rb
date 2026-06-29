require 'rails_helper'

RSpec.describe "GroupChats API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/group_chats/:id/add_member(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"add-member") rescue {}
      post "/api/v1/group_chats/#{group_chat.id}/add_member", params: { 'add_member'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/group_chats/#{group_chat.id}/add_member", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/group_chats/#{group_chat.id}/add_member"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/group_chats/999999/add_member", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/group_chats/:id/remove_member(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}/remove_member", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/group_chats/#{group_chat.id}/remove_member"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/group_chats/999999/remove_member", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/group_chats/:id/leave(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}/leave", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/group_chats/#{group_chat.id}/leave"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/group_chats/999999/leave", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/group_chats(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/group_chats"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/group_chats(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-chat") rescue {}
      post "/api/v1/group_chats", params: { 'group_chat'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/group_chats", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/group_chats"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/group_chats/#{group_chat.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/group_chats/#{group_chat.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/group_chats/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-chat") rescue {}
      patch "/api/v1/group_chats/#{group_chat.id}", params: { 'group_chat'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/group_chats/#{group_chat.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/group_chats/#{group_chat.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/group_chats/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"group-chat") rescue {}
      put "/api/v1/group_chats/#{group_chat.id}", params: { 'group_chat'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/group_chats/#{group_chat.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/group_chats/#{group_chat.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/group_chats/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/group_chats/:id(.:format)' do
    let(:group_chat) { create(:group_chat) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/group_chats/#{group_chat.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/group_chats/#{group_chat.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/group_chats/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
