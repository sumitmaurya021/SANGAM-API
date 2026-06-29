module Api
  module V1
    class HashtagsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_hashtag, only: [:show, :update, :destroy]

      def index
        records = Hashtag.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: HashtagBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        # In API, find by name similar to FullStack, or ID. FullStack uses name: params[:name].downcase.gsub(/\A#/, '')
        if params[:id].to_i == 0 && params[:id] != '0' # It's likely a string/name
          name = params[:id].downcase.gsub(/\A#/, '')
          @hashtag = Hashtag.find_by!(name: name)
        end
        
        posts = @hashtag.posts.includes(:user, :comments).order(created_at: :desc).page(params[:page]).per(12)
        
        render_success(
          message: 'Retrieved successfully',
          data: {
            hashtag: HashtagBlueprint.render_as_hash(@hashtag, view: :normal),
            posts: PostBlueprint.render_as_hash(posts, view: :normal)
          }
        )
      end

      def explore
        trending_hashtags = Hashtag.trending.limit(20) if Hashtag.respond_to?(:trending)
        trending_hashtags ||= Hashtag.order(posts_count: :desc).limit(20)

        # Recent posts with hashtags
        recent_posts = Post.includes(:user, :comments, :hashtags)
                           .where.not(hashtags: { id: nil })
                           .order(created_at: :desc)
                           .limit(20)

        render_success(
          message: 'Explore hashtags',
          data: {
            hashtags: HashtagBlueprint.render_as_hash(trending_hashtags, view: :normal),
            recent_posts: PostBlueprint.render_as_hash(recent_posts, view: :normal)
          }
        )
      end

      def create
        record = Hashtag.new(hashtag_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: HashtagBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @hashtag.update(hashtag_params)
          render_success(message: 'Updated successfully', data: HashtagBlueprint.render_as_hash(@hashtag, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @hashtag.errors.messages)
        end
      end

      def destroy
        @hashtag.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_hashtag
        @hashtag = Hashtag.find(params[:id])
      end

      def hashtag_params
        # Adjust permitted parameters as needed
        params.require(:hashtag).permit(:name, :posts_count)
      end
    end
  end
end
