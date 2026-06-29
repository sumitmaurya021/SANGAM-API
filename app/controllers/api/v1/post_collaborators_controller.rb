module Api
  module V1
    class PostCollaboratorsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_post

      def create
        if @post.user_id != @current_user.id
          return render_error(message: 'Only the post owner can invite collaborators', status: :forbidden)
        end

        collaborator = @post.post_collaborators.build(user_id: params[:user_id], status: 'pending')

        if collaborator.save
          render_success(message: 'Collaborator invited successfully', data: collaborator, status: :created)
        else
          render_error(message: 'Failed to invite collaborator', errors: collaborator.errors.messages)
        end
      end

      def accept
        collaborator = @post.post_collaborators.find_by(user_id: @current_user.id)
        return render_error(message: 'Invite not found', status: :not_found) unless collaborator

        if collaborator.update(status: 'accepted')
          render_success(message: 'Collaborator invite accepted')
        else
          render_error(message: 'Failed to accept invite', errors: collaborator.errors.messages)
        end
      end

      def reject
        collaborator = @post.post_collaborators.find_by(user_id: @current_user.id)
        return render_error(message: 'Invite not found', status: :not_found) unless collaborator

        if collaborator.update(status: 'rejected')
          render_success(message: 'Collaborator invite rejected')
        else
          render_error(message: 'Failed to reject invite', errors: collaborator.errors.messages)
        end
      end

      def destroy
        collaborator = @post.post_collaborators.find_by(user_id: params[:user_id])
        return render_error(message: 'Collaborator not found', status: :not_found) unless collaborator

        if @post.user_id != @current_user.id && collaborator.user_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        collaborator.destroy
        render_success(message: 'Collaborator removed successfully')
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
