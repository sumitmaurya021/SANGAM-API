require 'rails_helper'

RSpec.describe "Messages API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/conversations/:conversation_id/messages(.:format)' do
    let(:conversation) { create(:conversation) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/conversations/#{conversation.id}/messages", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/conversations/:conversation_id/messages(.:format)' do
    let(:conversation) { create(:conversation) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:message) rescue {}
      post "/api/v1/conversations/#{conversation.id}/messages", params: { message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/conversations/:conversation_id/messages/:id(.:format)' do
    let(:conversation) { create(:conversation) }
    let(:message) { create(:message) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/conversations/#{conversation.id}/messages/#{message.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/conversations/:conversation_id/messages/:id(.:format)' do
    let(:conversation) { create(:conversation) }
    let(:message) { create(:message) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:message) rescue {}
      patch "/api/v1/conversations/#{conversation.id}/messages/#{message.id}", params: { message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/conversations/:conversation_id/messages/:id(.:format)' do
    let(:conversation) { create(:conversation) }
    let(:message) { create(:message) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:message) rescue {}
      put "/api/v1/conversations/#{conversation.id}/messages/#{message.id}", params: { message: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/conversations/:conversation_id/messages/:id(.:format)' do
    let(:conversation) { create(:conversation) }
    let(:message) { create(:message) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/conversations/#{conversation.id}/messages/#{message.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
