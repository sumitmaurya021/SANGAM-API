require 'rails_helper'

RSpec.describe "PostCollaborators API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/posts/:post_id/post_collaborators/accept(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:accept) rescue {}
      post "/api/v1/posts/#{post.id}/post_collaborators/accept", params: { accept: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/posts/:post_id/post_collaborators/reject(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reject) rescue {}
      post "/api/v1/posts/#{post.id}/post_collaborators/reject", params: { reject: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/posts/:post_id/post_collaborators(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:post_collaborator) rescue {}
      post "/api/v1/posts/#{post.id}/post_collaborators", params: { post_collaborator: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/posts/:post_id/post_collaborators/:id(.:format)' do
    let(:post) { create(:post) }
    let(:post_collaborator) { create(:post_collaborator) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/posts/#{post.id}/post_collaborators/#{post_collaborator.id}", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
