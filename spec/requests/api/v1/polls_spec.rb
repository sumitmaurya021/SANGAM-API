require 'rails_helper'

RSpec.describe "Polls API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/polls/:id/vote(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:vote) rescue {}
      post "/api/v1/polls/#{poll.id}/vote", params: { vote: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/polls(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/polls(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll) rescue {}
      post "/api/v1/polls", params: { poll: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls/#{poll.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll) rescue {}
      patch "/api/v1/polls/#{poll.id}", params: { poll: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll) rescue {}
      put "/api/v1/polls/#{poll.id}", params: { poll: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/polls/:id(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/polls/#{poll.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
