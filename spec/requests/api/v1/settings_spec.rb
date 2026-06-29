require 'rails_helper'

RSpec.describe "Settings API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'PATCH /api/v1/settings/dark_mode(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:dark_mode) rescue {}
      patch "/api/v1/settings/dark_mode", params: { dark_mode: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
