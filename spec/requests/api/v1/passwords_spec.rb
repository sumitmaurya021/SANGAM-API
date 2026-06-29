require 'rails_helper'

RSpec.describe "Passwords API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/forgot-password(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:forgot-password) rescue {}
      post "/api/v1/auth/forgot-password", params: { forgot-password: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/auth/reset-password(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:reset-password) rescue {}
      post "/api/v1/auth/reset-password", params: { reset-password: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/auth/change-password(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:change-password) rescue {}
      post "/api/v1/auth/change-password", params: { change-password: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
