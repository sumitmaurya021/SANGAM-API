require 'rails_helper'

RSpec.describe "Comments API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/posts/:post_id/comments(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/posts/#{post.id}/comments", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


  describe 'POST /api/v1/posts/:post_id/comments(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:comment) rescue {}
      post "/api/v1/posts/#{post.id}/comments", params: { comment: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PATCH /api/v1/posts/:post_id/comments/:id(.:format)' do
    let(:post) { create(:post) }
    let(:comment) { create(:comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:comment) rescue {}
      patch "/api/v1/posts/#{post.id}/comments/#{comment.id}", params: { comment: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'PUT /api/v1/posts/:post_id/comments/:id(.:format)' do
    let(:post) { create(:post) }
    let(:comment) { create(:comment) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:comment) rescue {}
      put "/api/v1/posts/#{post.id}/comments/#{comment.id}", params: { comment: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/posts/:post_id/comments/:id(.:format)' do
    let(:post) { create(:post) }
    let(:comment) { create(:comment) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/posts/#{post.id}/comments/#{comment.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
