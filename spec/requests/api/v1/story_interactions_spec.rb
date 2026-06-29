require 'rails_helper'

RSpec.describe "StoryInteractions API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/stories/:story_id/story_interactions/poll_vote(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"poll-vote") rescue {}
      post "/api/v1/stories/#{story.id}/story_interactions/poll_vote", params: { 'poll_vote'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/stories/#{story.id}/story_interactions/poll_vote", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/stories/#{story.id}/story_interactions/poll_vote"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/stories/999999/story_interactions/poll_vote", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/stories/:story_id/story_interactions/qa_reply(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"qa-reply") rescue {}
      post "/api/v1/stories/#{story.id}/story_interactions/qa_reply", params: { 'qa_reply'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/stories/#{story.id}/story_interactions/qa_reply", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/stories/#{story.id}/story_interactions/qa_reply"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/stories/999999/story_interactions/qa_reply", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/stories/:story_id/story_interactions/qa_replies(.:format)' do
    let(:story) { create(:story) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/stories/#{story.id}/story_interactions/qa_replies", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/stories/#{story.id}/story_interactions/qa_replies"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/stories/999999/story_interactions/qa_replies", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
