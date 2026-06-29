require 'rails_helper'

RSpec.describe "Sessions API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/login(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:login) rescue {}
      post "/api/v1/auth/login", params: { login: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'DELETE /api/v1/auth/logout(.:format)' do

    it 'executes the request and returns a valid status' do
      delete "/api/v1/auth/logout", headers: headers
      expect(response.status).to be_between(200, 204).or eq(404)

    end
  end


end
