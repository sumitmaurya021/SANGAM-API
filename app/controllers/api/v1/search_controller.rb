module Api
  module V1
    class SearchController < ApplicationController
      before_action :authenticate_request!, except: [:index]

      def index
        query = params[:q].to_s.strip
        return render_error(message: 'Query parameter is required', status: :bad_request) if query.blank?

        if query.length < 2
          return render_success(message: 'Search query too short', data: {})
        end

        type = params[:type] || 'all'
        results = {}

        if %w[all people users].include?(type)
          users = User.where('name ILIKE :q OR email ILIKE :q', q: "%#{query}%")
          users = users.where.not(id: @current_user.id) if @current_user
          users = users.order(:name).limit(type == 'all' ? 5 : 20)
          results[:users] = UserBlueprint.render_as_hash(users, view: :normal)
        end

        if %w[all posts].include?(type)
          posts = Post.includes(:user, :comments)
          # Assuming Post.visible_to or similar logic is accessible, or just default to public posts
          posts = posts.where("content ILIKE ?", "%#{query}%")
                       .order(created_at: :desc)
                       .limit(type == 'all' ? 8 : 20)
          results[:posts] = PostBlueprint.render_as_hash(posts, view: :normal)
        end

        if %w[all groups].include?(type)
          groups = Group.where('name ILIKE :q OR description ILIKE :q', q: "%#{query}%")
          groups = groups.public_groups if Group.respond_to?(:public_groups)
          groups = groups.order(members_count: :desc).limit(type == 'all' ? 5 : 20)
          results[:groups] = GroupBlueprint.render_as_hash(groups, view: :normal)
        end

        if %w[all hashtags].include?(type)
          hashtags = Hashtag.where('name ILIKE ?', "%#{query}%")
          hashtags = hashtags.order(posts_count: :desc).limit(type == 'all' ? 10 : 20)
          results[:hashtags] = HashtagBlueprint.render_as_hash(hashtags, view: :normal)
        end

        if %w[all events].include?(type)
          events = Event.where('title ILIKE :q OR description ILIKE :q', q: "%#{query}%")
          events = events.upcoming if Event.respond_to?(:upcoming)
          events = events.where(privacy: 'public') if Event.attribute_names.include?('privacy')
          events = events.order(:starts_at).limit(type == 'all' ? 5 : 20)
          results[:events] = EventBlueprint.render_as_hash(events, view: :normal)
        end

        render_success(message: 'Search completed', data: results)
      end
    end
  end
end
