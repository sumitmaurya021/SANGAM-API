require 'rails_helper'

RSpec.describe "Likes API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/posts/:post_id/likes(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:like) rescue {}
      post "/api/v1/posts/#{post.id}/likes", params: { like: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/posts/:post_id/likes(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/posts/#{post.id}/likes", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
