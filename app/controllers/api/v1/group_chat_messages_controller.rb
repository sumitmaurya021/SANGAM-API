module Api
  module V1
    class GroupChatMessagesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_group_chat
      before_action :require_member!
      before_action :set_group_chat_message, only: [:show, :update, :destroy]

      def index
        messages = @group_chat.group_chat_messages.includes(:user)
        
        if params[:before_id].present?
          messages = messages.where('id < ?', params[:before_id].to_i)
        end

        messages = messages.order(created_at: :desc).limit(params[:per_page] || 30)
        messages = messages.to_a.reverse # Return chronological order for UI

        render_success(message: 'Retrieved successfully', data: GroupChatMessageBlueprint.render_as_hash(messages, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: GroupChatMessageBlueprint.render_as_hash(@group_chat_message, view: :normal))
      end

      def create
        record = @group_chat.group_chat_messages.build(group_chat_message_params)
        record.user_id = @current_user.id

        if record.save
          render_success(message: 'Created successfully', data: GroupChatMessageBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @group_chat_message.update(group_chat_message_params)
          render_success(message: 'Updated successfully', data: GroupChatMessageBlueprint.render_as_hash(@group_chat_message, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @group_chat_message.errors.messages)
        end
      end

      def destroy
        unless @group_chat_message.user_id == @current_user.id || @group_chat.admin?(@current_user)
          return render_error(message: 'Forbidden', status: :forbidden)
        end

        if @group_chat_message.respond_to?(:soft_delete!)
          @group_chat_message.soft_delete!
        else
          @group_chat_message.destroy
        end
        
        render_success(message: 'Deleted successfully')
      end

      private

      def set_group_chat
        @group_chat = GroupChat.find(params[:group_chat_id])
      end

      def require_member!
        unless @group_chat.member?(@current_user)
          render_error(message: 'Not a member', status: :forbidden)
        end
      end

      def set_group_chat_message
        @group_chat_message = @group_chat.group_chat_messages.find(params[:id])
      end

      def group_chat_message_params
        params.require(:group_chat_message).permit(:body, :message_type, :attachment)
      end
    end
  end
end
