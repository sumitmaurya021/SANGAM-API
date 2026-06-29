module Api
  module V1
    class StoriesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_story, only: [:show, :destroy, :view]
      before_action :authorize_story!, only: [:destroy]

      def index
        stories = Story.includes(:user).where('expires_at > ?', Time.current).order(created_at: :desc)
        stories = stories.page(params[:page]).per(params[:per_page] || 20)

        render_success(
          message: 'Stories retrieved successfully',
          data: {
            stories: StoryBlueprint.render_as_hash(stories, view: :normal),
            meta: {
              current_page: stories.current_page,
              total_pages: stories.total_pages,
              total_count: stories.total_count
            }
          }
        )
      end

      def active
        stories = Story.includes(:user).where('expires_at > ?', Time.current).order(created_at: :desc)
        render_success(message: 'Active stories retrieved', data: StoryBlueprint.render_as_hash(stories, view: :normal))
      end

      def show
        render_success(message: 'Story retrieved successfully', data: StoryBlueprint.render_as_hash(@story, view: :normal))
      end

      def create
        story = @current_user.stories.build(story_params)
        story.expires_at = 24.hours.from_now
        
        if story.save
          render_success(message: 'Story created successfully', data: StoryBlueprint.render_as_hash(story, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create story', errors: story.errors.messages)
        end
      end

      def share_to_story
        post = Post.find(params[:post_id])
        story = @current_user.stories.build(
          story_type: 'shared_post',
          is_shared_post: true,
          shared_post_id: post.id,
          expires_at: 24.hours.from_now
        )
        if story.save
          render_success(message: 'Post shared to story', data: StoryBlueprint.render_as_hash(story, view: :normal), status: :created)
        else
          render_error(message: 'Failed to share to story', errors: story.errors.messages)
        end
      end

      def destroy
        @story.destroy
        render_success(message: 'Story deleted successfully')
      end

      def view
        unless @story.story_views.exists?(user_id: @current_user.id)
          @story.story_views.create(user_id: @current_user.id)
        end
        render_success(message: 'Story marked as viewed')
      end

      private

      def set_story
        @story = Story.find(params[:id] || params[:story_id])
      end

      def authorize_story!
        unless @story.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def story_params
        params.require(:story).permit(:caption, :background_color, :text_color, :story_type, :is_shared_post, :shared_post_id)
      end
    end
  end
end
