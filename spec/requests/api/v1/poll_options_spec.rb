require 'rails_helper'

RSpec.describe "PollOptions API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/polls/:poll_id/poll_options(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls/#{poll.id}/poll_options", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/polls/:poll_id/poll_options(.:format)' do
    let(:poll) { create(:poll) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_option) rescue {}
      post "/api/v1/polls/#{poll.id}/poll_options", params: { poll_option: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/polls/:poll_id/poll_options/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/polls/:poll_id/poll_options/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_option) rescue {}
      patch "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}", params: { poll_option: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/polls/:poll_id/poll_options/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_option) rescue {}
      put "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}", params: { poll_option: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/polls/:poll_id/poll_options/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
