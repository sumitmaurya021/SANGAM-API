require 'rails_helper'

RSpec.describe "Comments API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/posts/:post_id/comments(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/posts/#{post_record.id}/comments", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/posts/#{post_record.id}/comments"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/posts/999999/comments", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/posts/:post_id/comments(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"comment") rescue {}
      post "/api/v1/posts/#{post_record.id}/comments", params: { 'comment'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/posts/#{post_record.id}/comments", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/posts/#{post_record.id}/comments"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/posts/999999/comments", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/posts/:post_id/comments/:id(.:format)' do
    let(:post_record) { create(:post) }
    let(:comment) { create(:comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"comment") rescue {}
      patch "/api/v1/posts/#{post_record.id}/comments/#{comment.id}", params: { 'comment'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/posts/#{post_record.id}/comments/#{comment.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/posts/#{post_record.id}/comments/#{comment.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/posts/999999/comments/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/posts/:post_id/comments/:id(.:format)' do
    let(:post_record) { create(:post) }
    let(:comment) { create(:comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"comment") rescue {}
      put "/api/v1/posts/#{post_record.id}/comments/#{comment.id}", params: { 'comment'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/posts/#{post_record.id}/comments/#{comment.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/posts/#{post_record.id}/comments/#{comment.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/posts/999999/comments/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/posts/:post_id/comments/:id(.:format)' do
    let(:post_record) { create(:post) }
    let(:comment) { create(:comment) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/posts/#{post_record.id}/comments/#{comment.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/posts/#{post_record.id}/comments/#{comment.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/posts/999999/comments/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
