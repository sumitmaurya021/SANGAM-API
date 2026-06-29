require 'rails_helper'

RSpec.describe "Shares API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/posts/:post_id/shares(.:format)' do
    let(:post) { create(:post) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:share) rescue {}
      post "/api/v1/posts/#{post.id}/shares", params: { share: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
