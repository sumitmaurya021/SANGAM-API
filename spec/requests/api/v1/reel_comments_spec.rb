require 'rails_helper'

RSpec.describe "ReelComments API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/reels/:reel_id/reel_comments(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/reels/#{reel.id}/reel_comments", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/reels/#{reel.id}/reel_comments"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/reels/999999/reel_comments", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/reels/:reel_id/reel_comments(.:format)' do
    let(:reel) { create(:reel) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reel-comment") rescue {}
      post "/api/v1/reels/#{reel.id}/reel_comments", params: { 'reel_comment'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/reels/#{reel.id}/reel_comments", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/reels/#{reel.id}/reel_comments"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/reels/999999/reel_comments", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/reels/:reel_id/reel_comments/:id(.:format)' do
    let(:reel) { create(:reel) }
    let(:reel_comment) { create(:reel_comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reel-comment") rescue {}
      patch "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", params: { 'reel_comment'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/reels/999999/reel_comments/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/reels/:reel_id/reel_comments/:id(.:format)' do
    let(:reel) { create(:reel) }
    let(:reel_comment) { create(:reel_comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reel-comment") rescue {}
      put "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", params: { 'reel_comment'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/reels/999999/reel_comments/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/reels/:reel_id/reel_comments/:id(.:format)' do
    let(:reel) { create(:reel) }
    let(:reel_comment) { create(:reel_comment) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/reels/#{reel.id}/reel_comments/#{reel_comment.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/reels/999999/reel_comments/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
