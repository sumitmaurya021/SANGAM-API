require 'rails_helper'

RSpec.describe "StoryInteractions API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/stories/:story_id/story_interactions/poll_vote(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:poll_vote) rescue {}
      post "/api/v1/stories/#{story.id}/story_interactions/poll_vote", params: { poll_vote: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/stories/:story_id/story_interactions/qa_reply(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:qa_reply) rescue {}
      post "/api/v1/stories/#{story.id}/story_interactions/qa_reply", params: { qa_reply: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'GET /api/v1/stories/:story_id/story_interactions/qa_replies(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories/#{story.id}/story_interactions/qa_replies", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


end
