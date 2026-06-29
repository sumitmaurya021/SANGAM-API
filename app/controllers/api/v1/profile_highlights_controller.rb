module Api
  module V1
    class ProfileHighlightsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show, :stories]
      before_action :set_profile_highlight, only: [:show, :update, :destroy, :add_story, :remove_story, :stories]
      before_action :authorize_highlight!, only: [:update, :destroy, :add_story, :remove_story]

      def index
        if params[:user_id]
          user = User.find(params[:user_id])
          records = user.profile_highlights.order(position: :asc, created_at: :desc)
        else
          records = ProfileHighlight.order(position: :asc, created_at: :desc)
        end

        records = records.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: ProfileHighlightBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: ProfileHighlightBlueprint.render_as_hash(@profile_highlight, view: :normal))
      end

      def create
        record = @current_user.profile_highlights.build(profile_highlight_params)

        if record.save
          render_success(message: 'Created successfully', data: ProfileHighlightBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @profile_highlight.update(profile_highlight_params)
          render_success(message: 'Updated successfully', data: ProfileHighlightBlueprint.render_as_hash(@profile_highlight, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @profile_highlight.errors.messages)
        end
      end

      def destroy
        @profile_highlight.destroy
        render_success(message: 'Deleted successfully')
      end

      def stories
        stories = @profile_highlight.stories
                                    .order('highlight_stories.position ASC, stories.created_at DESC')
                                    .includes(:user)
                                    
        render_success(message: 'Stories retrieved', data: StoryBlueprint.render_as_hash(stories, view: :normal))
      end

      def add_story
        story = @current_user.stories.find(params[:story_id])
        HighlightStory.find_or_create_by!(profile_highlight: @profile_highlight, story: story)
        render_success(message: 'Story added to highlight', data: ProfileHighlightBlueprint.render_as_hash(@profile_highlight, view: :normal))
      rescue ActiveRecord::RecordNotFound
        render_error(message: 'Story not found', status: :not_not_found)
      end

      def remove_story
        hs = HighlightStory.find_by!(profile_highlight: @profile_highlight, story_id: params[:story_id])
        hs.destroy
        render_success(message: 'Story removed from highlight')
      rescue ActiveRecord::RecordNotFound
        render_error(message: 'Not found', status: :not_found)
      end

      private

      def set_profile_highlight
        @profile_highlight = ProfileHighlight.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render_error(message: 'Highlight not found', status: :not_found)
      end

      def authorize_highlight!
        unless @profile_highlight.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def profile_highlight_params
        params.require(:profile_highlight).permit(:emoji, :name, :position)
      end
    end
  end
end
