module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_post

      def create
        like = @post.likes.build(user: @current_user)
        
        if like.save
          render_success(message: 'Post liked successfully', data: LikeBlueprint.render_as_hash(like, view: :normal), status: :created)
        else
          render_error(message: 'Failed to like post', errors: like.errors.messages)
        end
      end

      def destroy
        like = @post.likes.find_by(user: @current_user)
        
        if like&.destroy
          render_success(message: 'Post unliked successfully')
        else
          render_error(message: 'Like not found', status: :not_found)
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
