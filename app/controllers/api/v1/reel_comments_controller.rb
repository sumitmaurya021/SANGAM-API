module Api
  module V1
    class ReelCommentsController < ApplicationController
      before_action :authenticate_request!, except: [:index]
      before_action :set_reel, only: [:index, :create]
      before_action :set_comment, only: [:update, :destroy]

      def index
        comments = @reel.reel_comments
        comments = comments.page(params[:page]).per(params[:per_page] || 20)

        render_success(
          message: 'Reel comments retrieved successfully',
          data: {
            comments: comments.as_json(include: :user),
            meta: {
              current_page: comments.current_page,
              total_pages: comments.total_pages,
              total_count: comments.total_count
            }
          }
        )
      end

      def create
        comment = @reel.reel_comments.build(comment_params)
        comment.user = @current_user
        
        if comment.save
          render_success(message: 'Reel comment added successfully', data: comment, status: :created)
        else
          render_error(message: 'Failed to add reel comment', errors: comment.errors.messages)
        end
      end

      def update
        if @comment.user_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        if @comment.update(comment_params)
          render_success(message: 'Reel comment updated successfully', data: @comment)
        else
          render_error(message: 'Failed to update reel comment', errors: @comment.errors.messages)
        end
      end

      def destroy
        if @comment.user_id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        @comment.destroy
        render_success(message: 'Reel comment deleted successfully')
      end

      private

      def set_reel
        @reel = Reel.find(params[:reel_id])
      end

      def set_comment
        @comment = ReelComment.find(params[:id])
      end

      def comment_params
        params.require(:reel_comment).permit(:content, :parent_id)
      end
    end
  end
end
