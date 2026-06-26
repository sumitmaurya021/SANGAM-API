module Api
  module V1
    class CloseFriendsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_close_friend, only: [:show, :update, :destroy]

      def index
        records = CloseFriend.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: CloseFriendBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: CloseFriendBlueprint.render_as_hash(@close_friend, view: :normal))
      end

      def create
        record = CloseFriend.new(close_friend_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: CloseFriendBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @close_friend.update(close_friend_params)
          render_success(message: 'Updated successfully', data: CloseFriendBlueprint.render_as_hash(@close_friend, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @close_friend.errors.messages)
        end
      end

      def destroy
        @close_friend.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_close_friend
        @close_friend = CloseFriend.find(params[:id])
      end

      def close_friend_params
        # Adjust permitted parameters as needed
        params.require(:close_friend).permit(:close_friend_id, :user_id)
      end
    end
  end
end
