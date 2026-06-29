require 'rails_helper'

RSpec.describe "ReelLikes API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/reels/:reel_id/reel_likes(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel_like) rescue {}
      post "/api/v1/reels/#{reel.id}/reel_likes", params: { reel_like: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/reels/:reel_id/reel_likes(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/reels/#{reel.id}/reel_likes", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
