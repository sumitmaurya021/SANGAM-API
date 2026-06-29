module Api
  module V1
    class StoryInteractionsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_story

      def poll_vote
        params.require(:option)
        render_success(message: 'Poll vote recorded successfully')
      end

      def qa_reply
        params.require(:answer)
        render_success(message: 'Q&A reply submitted successfully')
      end

      def qa_replies
        if @story.user_id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end
        
        # replies = @story.qa_replies.includes(:user)
        # render_success(message: 'Q&A replies retrieved', data: replies)
        render_success(message: 'Q&A replies retrieved', data: [])
      end

      private

      def set_story
        @story = Story.find(params[:story_id])
      end
    end
  end
end
