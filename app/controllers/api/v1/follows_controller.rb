module Api
  module V1
    class FollowsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_follow, only: [:show]
      before_action :set_followee, only: [:create, :destroy]

      def index
        records = Follow.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: FollowBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: FollowBlueprint.render_as_hash(@follow, view: :normal))
      end

      def create
        if @current_user.id == @followee.id
          return render_error(message: "You can't follow yourself.", status: :unprocessable_entity)
        end

        record = @current_user.active_follows.build(followee: @followee)

        if record.save
          render_success(message: 'Created successfully', data: FollowBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def destroy
        @follow = @current_user.active_follows.find_by(followee: @followee)
        if @follow
          @follow.destroy
          render_success(message: 'Deleted successfully')
        else
          render_error(message: 'Could not unfollow', status: :unprocessable_entity)
        end
      end

      private

      def set_follow
        @follow = Follow.find(params[:id])
      end

      def set_followee
        @followee = User.find(params[:followee_id] || follow_params[:followee_id] || params[:id])
      end

      def follow_params
        # Adjust permitted parameters as needed
        params.fetch(:follow, {}).permit(:followee_id)
      end
    end
  end
end
