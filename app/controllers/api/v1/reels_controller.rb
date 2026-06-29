module Api
  module V1
    class ReelsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_reel, only: [:show, :update, :destroy, :view]

      def index
        reels = Reel.includes(:user).order(created_at: :desc)
        reels = reels.page(params[:page]).per(params[:per_page] || 10)

        render_success(
          message: 'Reels retrieved successfully',
          data: {
            reels: ReelBlueprint.render_as_hash(reels, view: :normal),
            meta: {
              current_page: reels.current_page,
              total_pages: reels.total_pages,
              total_count: reels.total_count
            }
          }
        )
      end

      def show
        render_success(message: 'Reel retrieved successfully', data: ReelBlueprint.render_as_hash(@reel, view: :normal))
      end

      def create
        reel = @current_user.reels.build(reel_params)
        
        if reel.save
          render_success(message: 'Reel created successfully', data: ReelBlueprint.render_as_hash(reel, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create reel', errors: reel.errors.messages)
        end
      end

      def update
        if @reel.user_id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        if @reel.update(reel_params)
          render_success(message: 'Reel updated successfully', data: ReelBlueprint.render_as_hash(@reel, view: :normal))
        else
          render_error(message: 'Failed to update reel', errors: @reel.errors.messages)
        end
      end

      def destroy
        if @reel.user_id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        @reel.destroy
        render_success(message: 'Reel deleted successfully')
      end

      def view
        @reel.increment_views!
        render_success(message: 'Reel view recorded', data: { views_count: @reel.views_count })
      end

      private

      def set_reel
        @reel = Reel.find(params[:id])
      end

      def reel_params
        params.require(:reel).permit(:caption, :music, :music_artist, :music_preview_url, :music_title, :hashtags)
      end
    end
  end
end
