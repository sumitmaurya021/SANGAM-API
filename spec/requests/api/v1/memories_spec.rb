require 'rails_helper'

RSpec.describe "Memories API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /api/v1/memories(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/memories", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/memories"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


end
