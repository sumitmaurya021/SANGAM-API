module Api
  module V1
    class SharesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_post

      def create
        share = @post.shares.build(user: @current_user)
        
        if share.save
          render_success(message: 'Post shared successfully', data: ShareBlueprint.render_as_hash(share, view: :normal), status: :created)
        else
          render_error(message: 'Failed to share post', errors: share.errors.messages)
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
