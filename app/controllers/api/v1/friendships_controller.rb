module Api
  module V1
    class FriendshipsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_friendship, only: [:update, :destroy, :accept, :reject]

      def index
        # List pending requests for current user
        incoming = Friendship.where(friend_id: @current_user.id, status: 'pending')
        outgoing = Friendship.where(user_id: @current_user.id, status: 'pending')

        render_success(
          message: 'Friendship requests retrieved',
          data: {
            incoming: incoming.as_json(include: :user),
            outgoing: outgoing.as_json(include: :friend)
          }
        )
      end

      def create
        friend_id = params[:friend_id] || params.dig(:friendship, :friend_id)
        if @current_user.id.to_s == friend_id.to_s
          return render_error(message: "You can't send a friend request to yourself")
        end

        friendship = Friendship.find_or_initialize_by(user_id: @current_user.id, friend_id: friend_id)
        
        if friendship.persisted?
          return render_error(message: "Friend request already sent or exists")
        end

        friendship.status = 'pending'
        
        if friendship.save
          render_success(message: 'Friend request sent', data: FriendshipBlueprint.render_as_hash(friendship, view: :normal), status: :created)
        else
          render_error(message: 'Failed to send friend request', errors: friendship.errors.messages)
        end
      end

      def update
        # Generic update
        if @friendship.friend_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        new_status = params[:status] || params.dig(:friendship, :status)
        unless %w[accepted rejected].include?(new_status)
          return render_error(message: 'Invalid status')
        end

        if @friendship.update(status: new_status)
          render_success(message: "Friend request #{new_status}", data: FriendshipBlueprint.render_as_hash(@friendship, view: :normal))
        else
          render_error(message: 'Failed to update request', errors: @friendship.errors.messages)
        end
      end

      def accept
        if @friendship.friend_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        if @friendship.update(status: 'accepted')
          render_success(message: 'Friend request accepted', data: FriendshipBlueprint.render_as_hash(@friendship, view: :normal))
        else
          render_error(message: 'Failed to accept request', errors: @friendship.errors.messages)
        end
      end

      def reject
        if @friendship.friend_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        if @friendship.update(status: 'rejected')
          render_success(message: 'Friend request rejected', data: FriendshipBlueprint.render_as_hash(@friendship, view: :normal))
        else
          render_error(message: 'Failed to reject request', errors: @friendship.errors.messages)
        end
      end

      def destroy
        # Cancel or unfriend
        if @friendship.user_id != @current_user.id && @friendship.friend_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        @friendship.destroy
        render_success(message: 'Friendship or request removed successfully')
      end

      private

      def set_friendship
        @friendship = Friendship.find(params[:id])
      end
    end
  end
end
