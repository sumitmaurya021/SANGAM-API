module Api
  module V1
    class ReelLikesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_reel

      def create
        like = @reel.reel_likes.build(user: @current_user)
        
        if like.save
          render_success(message: 'Reel liked successfully', data: like, status: :created)
        else
          render_error(message: 'Failed to like reel', errors: like.errors.messages)
        end
      end

      def destroy
        like = @reel.reel_likes.find_by(user: @current_user)
        
        if like&.destroy
          render_success(message: 'Reel unliked successfully')
        else
          render_error(message: 'Like not found', status: :not_found)
        end
      end

      private

      def set_reel
        @reel = Reel.find(params[:reel_id])
      end
    end
  end
end
