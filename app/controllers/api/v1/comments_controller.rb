module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_request!, except: [:index]
      before_action :set_post, only: [:index, :create]
      before_action :set_comment, only: [:update, :destroy]

      def index
        comments = @post.comments
        comments = comments.page(params[:page]).per(params[:per_page] || 20)

        render_success(
          message: 'Comments retrieved successfully',
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
        comment = @post.comments.build(comment_params)
        comment.user = @current_user
        
        if comment.save
          render_success(message: 'Comment added successfully', data: CommentBlueprint.render_as_hash(comment, view: :normal), status: :created)
        else
          render_error(message: 'Failed to add comment', errors: comment.errors.messages)
        end
      end

      def update
        if @comment.user_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        if @comment.update(comment_params)
          render_success(message: 'Comment updated successfully', data: CommentBlueprint.render_as_hash(@comment, view: :normal))
        else
          render_error(message: 'Failed to update comment', errors: @comment.errors.messages)
        end
      end

      def destroy
        if @comment.user_id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        @comment.destroy
        render_success(message: 'Comment deleted successfully')
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:content, :parent_id)
      end
    end
  end
end
