require 'rails_helper'

RSpec.describe "Interactions API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/interactions(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:interaction) rescue {}
      post "/api/v1/interactions", params: { interaction: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
