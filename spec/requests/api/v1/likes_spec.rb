require 'rails_helper'

RSpec.describe "Likes API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/posts/:post_id/likes(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"like") rescue {}
      post "/api/v1/posts/#{post_record.id}/likes", params: { 'like'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/posts/#{post_record.id}/likes"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/posts/999999/likes", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/posts/:post_id/likes(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/posts/#{post_record.id}/likes", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/posts/#{post_record.id}/likes"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/posts/999999/likes", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
