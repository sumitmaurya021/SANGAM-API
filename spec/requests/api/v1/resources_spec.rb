require 'rails_helper'

RSpec.describe 'Core API Resources', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'Posts API' do
    let!(:user_post) { create(:post, user: user) }

    it 'lists posts' do
      get '/api/v1/posts', headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['success']).to be true
    end

    it 'shows a post' do
      get "/api/v1/posts/#{user_post.id}", headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'creates a post' do
      expect {
        post '/api/v1/posts', params: { post: { content: 'New post content', visibility: 'public' } }, headers: headers
      }.to change(Post, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'updates a post' do
      patch "/api/v1/posts/#{user_post.id}", params: { post: { content: 'Updated content' } }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(user_post.reload.content).to eq('Updated content')
    end

    it 'destroys a post' do
      expect {
        delete "/api/v1/posts/#{user_post.id}", headers: headers
      }.to change(Post, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end

    it 'likes a post' do
      post "/api/v1/posts/#{user_post.id}/likes", headers: headers
      expect(response).to have_http_status(:created)
      expect(user_post.likes.count).to eq(1)
    end
  end

  describe 'Comments API' do
    let!(:user_post) { create(:post) }
    let!(:comment) { create(:comment, post: user_post, user: user) }

    it 'lists comments' do
      get "/api/v1/posts/#{user_post.id}/comments", headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'creates a comment' do
      expect {
        post "/api/v1/posts/#{user_post.id}/comments", params: { comment: { content: 'Nice post!' } }, headers: headers
      }.to change(Comment, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'Reels API' do
    let!(:reel) { create(:reel, user: user) }

    it 'lists reels' do
      get '/api/v1/reels', headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'creates a reel' do
      expect {
        post '/api/v1/reels', params: { reel: { caption: 'Cool clip', duration: 15 } }, headers: headers
      }.to change(Reel, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'Groups API' do
    let!(:group) { create(:group, owner: user) }

    it 'lists groups' do
      get '/api/v1/groups', headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'creates a group' do
      expect {
        post '/api/v1/groups', params: { group: { name: 'My New Group', privacy: 'public' } }, headers: headers
      }.to change(Group, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'allows joining group' do
      post "/api/v1/groups/#{group.id}/join", headers: auth_headers(other_user)
      expect(response).to have_http_status(:ok)
      expect(group.users.include?(other_user)).to be true
    end
  end

  describe 'Friendships API' do
    it 'creates friend requests' do
      expect {
        post '/api/v1/friendships', params: { friendship: { friend_id: other_user.id } }, headers: headers
      }.to change(Friendship, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'accepts friend requests' do
      friendship = create(:friendship, user: other_user, friend: user, status: 'pending')
      post "/api/v1/friendships/#{friendship.id}/accept", headers: headers
      expect(response).to have_http_status(:ok)
      expect(friendship.reload.status).to eq('accepted')
    end
  end

  describe 'Conversations API' do
    let!(:conversation) { create(:conversation, sender: user, recipient: other_user) }

    it 'lists conversations' do
      get '/api/v1/conversations', headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'lists messages in conversation' do
      get "/api/v1/conversations/#{conversation.id}/messages", headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'sends message' do
      expect {
        post "/api/v1/conversations/#{conversation.id}/messages", params: { message: { body: 'Hello!' } }, headers: headers
      }.to change(Message, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'Admin API' do
    let!(:admin) { create(:user, super_admin: true) }
    let(:admin_headers) { auth_headers(admin) }

    it 'accesses admin dashboard' do
      get '/api/v1/admin/dashboard', headers: admin_headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['success']).to be true
    end

    it 'denies dashboard access to non-admin' do
      get '/api/v1/admin/dashboard', headers: headers
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'Bookmarks API' do
    let!(:collection) { create(:bookmark_collection, user: user) }
    let!(:post_item) { create(:post) }

    it 'creates collections' do
      expect {
        post '/api/v1/bookmark_collections', params: { bookmark_collection: { name: 'Read Later' } }, headers: headers
      }.to change(BookmarkCollection, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'adds bookmarks to collections' do
      patch "/api/v1/bookmark_collections/#{collection.id}/add_bookmark", params: {
        bookmarkable_type: 'Post',
        bookmarkable_id: post_item.id
      }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(collection.bookmarks.count).to eq(1)
    end
  end
end
