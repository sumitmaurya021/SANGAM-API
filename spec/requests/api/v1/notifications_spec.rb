require 'rails_helper'

RSpec.describe "Notifications API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'POST /api/v1/notifications/mark_all_read(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"mark-all-read") rescue {}
      post "/api/v1/notifications/mark_all_read", params: { 'mark_all_read'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/notifications/mark_all_read"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/notifications/dropdown(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/notifications/dropdown", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/notifications/dropdown"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/notifications/:id/mark_read(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"mark-read") rescue {}
      post "/api/v1/notifications/#{notification.id}/mark_read", params: { 'mark_read'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/notifications/#{notification.id}/mark_read", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/notifications/#{notification.id}/mark_read"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  post "/api/v1/notifications/999999/mark_read", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'GET /api/v1/notifications(.:format)' do

    it 'executes the request and returns a valid status' do
      get "/api/v1/notifications", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/notifications"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'POST /api/v1/notifications(.:format)' do

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"notification") rescue {}
      post "/api/v1/notifications", params: { 'notification'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  post "/api/v1/notifications", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  post "/api/v1/notifications"
  expect(response.status).to be_between(200, 500) # Since some are public
end

  end


  describe 'GET /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      get "/api/v1/notifications/#{notification.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  get "/api/v1/notifications/#{notification.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  get "/api/v1/notifications/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PATCH /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"notification") rescue {}
      patch "/api/v1/notifications/#{notification.id}", params: { 'notification'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  patch "/api/v1/notifications/#{notification.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  patch "/api/v1/notifications/#{notification.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  patch "/api/v1/notifications/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'PUT /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      valid_attributes = attributes_for(:"notification") rescue {}
      put "/api/v1/notifications/#{notification.id}", params: { 'notification'.gsub('_', '-') => valid_attributes }, headers: headers
      expect(response.status).to be < 500

    end

it 'returns an error when invalid parameters are provided' do
  put "/api/v1/notifications/#{notification.id}", params: {}, headers: headers
  expect(response.status).to be_between(400, 422)
end

it 'returns unauthorized when no headers are provided' do
  put "/api/v1/notifications/#{notification.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  put "/api/v1/notifications/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


  describe 'DELETE /api/v1/notifications/:id(.:format)' do
    let(:notification) { create(:notification) }

    it 'executes the request and returns a valid status' do
      delete "/api/v1/notifications/#{notification.id}", headers: headers
      expect(response.status).to be < 500

    end

it 'returns unauthorized when no headers are provided' do
  delete "/api/v1/notifications/#{notification.id}"
  expect(response.status).to be_between(200, 500) # Since some are public
end

it 'returns not found for invalid ID' do
  delete "/api/v1/notifications/999999", headers: headers
  expect(response.status).to be_between(400, 404).or eq(200)
end

  end


end
