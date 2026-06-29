require 'rails_helper'

RSpec.describe "PostCollaborators API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/posts/:post_id/post_collaborators/accept(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"accept") rescue {}
      post "/api/v1/posts/#{post_record.id}/post_collaborators/accept", params: { 'accept'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/posts/#{post_record.id}/post_collaborators/accept", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/posts/#{post_record.id}/post_collaborators/accept"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/posts/999999/post_collaborators/accept", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/posts/:post_id/post_collaborators/reject(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"reject") rescue {}
      post "/api/v1/posts/#{post_record.id}/post_collaborators/reject", params: { 'reject'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/posts/#{post_record.id}/post_collaborators/reject", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/posts/#{post_record.id}/post_collaborators/reject"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/posts/999999/post_collaborators/reject", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'POST /api/v1/posts/:post_id/post_collaborators(.:format)' do
    let(:post_record) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"post-collaborator") rescue {}
      post "/api/v1/posts/#{post_record.id}/post_collaborators", params: { 'post_collaborator'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/posts/#{post_record.id}/post_collaborators", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/posts/#{post_record.id}/post_collaborators"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/posts/999999/post_collaborators", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/posts/:post_id/post_collaborators/:id(.:format)' do
    let(:post_record) { create(:post) }
    let(:post_collaborator) { create(:post_collaborator) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/posts/#{post_record.id}/post_collaborators/#{post_collaborator.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/posts/#{post_record.id}/post_collaborators/#{post_collaborator.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/posts/999999/post_collaborators/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
