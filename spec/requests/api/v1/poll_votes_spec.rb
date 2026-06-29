require 'rails_helper'

RSpec.describe "PollVotes API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/polls/:poll_id/poll_options/:poll_option_id/poll_votes(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}/poll_votes", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/polls/:poll_id/poll_options/:poll_option_id/poll_votes(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_vote) rescue {}
      post "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}/poll_votes", params: { poll_vote: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/polls/:poll_id/poll_options/:poll_option_id/poll_votes/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }
    let(:poll_vote) { create(:poll_vote) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}/poll_votes/#{poll_vote.id}", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'PATCH /api/v1/polls/:poll_id/poll_options/:poll_option_id/poll_votes/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }
    let(:poll_vote) { create(:poll_vote) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_vote) rescue {}
      patch "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}/poll_votes/#{poll_vote.id}", params: { poll_vote: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/polls/:poll_id/poll_options/:poll_option_id/poll_votes/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }
    let(:poll_vote) { create(:poll_vote) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_vote) rescue {}
      put "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}/poll_votes/#{poll_vote.id}", params: { poll_vote: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/polls/:poll_id/poll_options/:poll_option_id/poll_votes/:id(.:format)' do
    let(:poll) { create(:poll) }
    let(:poll_option) { create(:poll_option) }
    let(:poll_vote) { create(:poll_vote) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/polls/#{poll.id}/poll_options/#{poll_option.id}/poll_votes/#{poll_vote.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
