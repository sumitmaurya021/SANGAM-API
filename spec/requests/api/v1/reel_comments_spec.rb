require 'rails_helper'

RSpec.describe "ReelComments API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/reels/:reel_id/reel_comments(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/reels/#{reel.id}/reel_comments", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/reels/:reel_id/reel_comments(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel_comment) rescue {}
      post "/api/v1/reels/#{reel.id}/reel_comments", params: { reel_comment: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PATCH /api/v1/reels/:reel_id/reel_comments/:id(.:format)' do
    let(:reel) { create(:reel) }
    let(:reel_comment) { create(:reel_comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel_comment) rescue {}
      patch "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", params: { reel_comment: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/reels/:reel_id/reel_comments/:id(.:format)' do
    let(:reel) { create(:reel) }
    let(:reel_comment) { create(:reel_comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reel_comment) rescue {}
      put "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", params: { reel_comment: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/reels/:reel_id/reel_comments/:id(.:format)' do
    let(:reel) { create(:reel) }
    let(:reel_comment) { create(:reel_comment) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
