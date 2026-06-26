Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :auth do
        post 'signup', to: 'registrations#create'
        post 'login', to: 'sessions#create'
        delete 'logout', to: 'sessions#destroy'
        
        post 'verify-otp', to: 'otps#verify'
        post 'resend-otp', to: 'otps#resend'
        
        post 'forgot-password', to: 'passwords#forgot'
        post 'reset-password', to: 'passwords#reset'
        post 'change-password', to: 'passwords#update'

        get 'confirmation', to: 'confirmations#show'
        post 'confirmation', to: 'confirmations#create'

        get 'unlock', to: 'unlocks#show'
        post 'unlock', to: 'unlocks#create'

        post 'totp/enable', to: 'totp#enable'
        post 'totp/confirm', to: 'totp#confirm'
        post 'totp/disable', to: 'totp#disable'

        post ':provider/callback', to: 'omniauth_callbacks#callback'
      end

      # Phase 4
      resources :users, only: [:index, :show, :update, :destroy]
      resources :profiles, only: [:show] do
        collection do
          get :friends_list
          get :search
          post :toggle_dark_mode
        end
        member do
          get :friends
          get :followers
          get :following
        end
      end

      resources :posts do
        resources :comments, only: [:index, :create, :update, :destroy]
        resources :likes, only: [:create]
        delete 'likes', to: 'likes#destroy'
        resources :shares, only: [:create]
        resources :post_collaborators, only: [:create, :destroy] do
          collection do
            post :accept
            post :reject
          end
        end
      end
      resources :reels do
        member do
          post :view
        end
        resources :reel_comments, only: [:index, :create, :update, :destroy]
        resources :reel_likes, only: [:create]
        delete 'reel_likes', to: 'reel_likes#destroy'
      end
      resources :stories do
        collection do
          post :share_to_story
          get :active
        end
        member do
          post :view
        end
        resources :story_interactions, only: [] do
          collection do
            post :poll_vote
            post :qa_reply
            get :qa_replies
          end
        end
      end

      # Phase 5
      resources :groups do
        member do
          post :join
          delete :leave
          post :approve_member
          delete :remove_member
        end
        resources :group_memberships
      end
      resources :events do
        member do
          post :respond, to: 'events#respond_to_event'
        end
        resources :event_responses
      end
      resources :fundraisers do
        member do
          post :donate
        end
      end
      resources :marketplace_listings do
        collection do
          get :my_listings
        end
        member do
          patch :mark_sold
        end
      end

      # Phase 6
      resources :friendships do
        member do
          post :accept
          post :reject
        end
      end
      resources :follows
      resources :close_friends
      resources :conversations do
        resources :messages
      end
      resources :group_chats do
        member do
          post :add_member
          delete :remove_member
          delete :leave
        end
        resources :group_chat_messages
      end
      resources :notifications do
        collection do
          post :mark_all_read
          get :dropdown
        end
        member do
          post :mark_read
        end
      end

      # Phase C: Auxiliary Endpoints
      get 'search', to: 'search#index'
      get 'music_search', to: 'music_search#search'
      get 'link_previews', to: 'link_previews#show'
      get 'memories', to: 'memories#index'
      post 'interactions', to: 'interactions#create'
      
      namespace :ai_features do
        post :generate_caption
        post :rewrite_message
        post :smart_reply
        get :search
        post :generate_smart_replies
        post :generate_article_content
        post :auto_fill_listing
      end

      patch 'settings/dark_mode', to: 'settings#toggle_dark_mode'

      namespace :admin do
        get 'dashboard', to: 'dashboard#index'
        get 'dashboard/users', to: 'dashboard#users'
        get 'dashboard/posts', to: 'dashboard#posts'
        get 'dashboard/users/:id', to: 'dashboard#user_details'
      end

      # Phase 7
      resources :articles
      resources :bookmarks
      resources :bookmark_collections do
        member do
          patch :add_bookmark
        end
      end
      resources :polls do
        member do
          post :vote
        end
        resources :poll_options do
          resources :poll_votes
        end
      end
      resources :hashtags do
        collection do
          get :explore
        end
      end
      resources :category_tags
      resources :profile_highlights do
        collection do
          get :index, as: ''
        end
        member do
          post :add_story
          delete :remove_story
          get :stories
        end
      end
    end
  end
end
