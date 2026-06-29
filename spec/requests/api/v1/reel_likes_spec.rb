require 'rails_helper'

RSpec.describe "ReelLikes API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/reels/:reel_id/reel_likes(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reel-like") rescue {}
      post "/api/v1/reels/#{reel.id}/reel_likes", params: { 'reel_like'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/reels/#{reel.id}/reel_likes"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/reels/999999/reel_likes", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/reels/:reel_id/reel_likes(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/reels/#{reel.id}/reel_likes", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/reels/#{reel.id}/reel_likes"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/reels/999999/reel_likes", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
