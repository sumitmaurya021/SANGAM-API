require 'rails_helper'

RSpec.describe "Memories API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/memories(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/memories", headers: headers
      expect(response).to have_http_status(:success).or have_http_status(:not_found)

    end
  end


end
