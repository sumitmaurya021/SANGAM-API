require 'rails_helper'

RSpec.describe "Totp API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/auth/totp/enable(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:enable) rescue {}
      post "/api/v1/auth/totp/enable", params: { enable: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/auth/totp/confirm(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:confirm) rescue {}
      post "/api/v1/auth/totp/confirm", params: { confirm: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


  describe 'POST /api/v1/auth/totp/disable(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:disable) rescue {}
      post "/api/v1/auth/totp/disable", params: { disable: valid_attributes }, headers: headers
      expect(response.status).to be_between(200, 422)

    end
  end


end
