module Api
  module V1
    class GroupChatsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_group_chat, only: [:show, :update, :destroy, :add_member, :remove_member, :leave]
      before_action :require_member!, only: [:show, :leave]
      before_action :require_admin!, only: [:update, :add_member, :remove_member]
      before_action :require_owner!, only: [:destroy]

      def index
        records = GroupChat.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: GroupChatBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: GroupChatBlueprint.render_as_hash(@group_chat, view: :normal))
      end

      def create
        record = GroupChat.new(group_chat_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: GroupChatBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @group_chat.update(group_chat_params)
          render_success(message: 'Updated successfully', data: GroupChatBlueprint.render_as_hash(@group_chat, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @group_chat.errors.messages)
        end
      end

      def destroy
        @group_chat.destroy
        render_success(message: 'Deleted successfully')
      end

      def add_member
        user = User.find(params[:user_id])
        member = @group_chat.group_chat_members.find_or_initialize_by(user: user)
        member.role = params[:role] || 'member'

        if member.save
          render_success(message: 'Member added', data: member)
        else
          render_error(message: 'Failed to add member', errors: member.errors.messages)
        end
      end

      def remove_member
        member = @group_chat.group_chat_members.find_by(user_id: params[:user_id])
        if member
          member.destroy
          render_success(message: 'Member removed')
        else
          render_error(message: 'Member not found', status: :not_found)
        end
      end

      def leave
        member = @group_chat.group_chat_members.find_by(user_id: @current_user.id)
        if member
          member.destroy
          render_success(message: 'Left group chat')
        else
          render_error(message: 'Not a member', status: :bad_request)
        end
      end

      private

      def set_group_chat
        @group_chat = GroupChat.find(params[:id] || params[:group_chat_id])
      end

      def require_member!
        unless @group_chat.group_chat_members.exists?(user_id: @current_user.id) || @current_user.super_admin?
          render_error(message: 'Not a member', status: :forbidden)
        end
      end

      def require_admin!
        member = @group_chat.group_chat_members.find_by(user_id: @current_user.id)
        unless (member && %w[admin owner].include?(member.role)) || @current_user.super_admin?
          render_error(message: 'Admin access required', status: :forbidden)
        end
      end

      def require_owner!
        member = @group_chat.group_chat_members.find_by(user_id: @current_user.id)
        unless (member && member.role == 'owner') || @current_user.super_admin?
          render_error(message: 'Owner access required', status: :forbidden)
        end
      end

      def group_chat_params
        # Adjust permitted parameters as needed
        params.require(:group_chat).permit(:description, :members_count, :name, :owner_id)
      end
    end
  end
end
