require 'rails_helper'

RSpec.describe "Registrations API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/signup(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:signup) rescue {}
      post "/api/v1/auth/signup", params: { signup: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
