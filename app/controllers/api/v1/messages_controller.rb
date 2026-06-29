module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_conversation
      before_action :set_message, only: [:show, :update, :destroy]

      def index
        records = @conversation.messages.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: MessageBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: MessageBlueprint.render_as_hash(@message, view: :normal))
      end

      def create
        record = @conversation.messages.build(message_params)
        record.user_id = @current_user.id

        if record.save
          render_success(message: 'Created successfully', data: MessageBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @message.update(message_params)
          render_success(message: 'Updated successfully', data: MessageBlueprint.render_as_hash(@message, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @message.errors.messages)
        end
      end

      def destroy
        if @message.user_id == @current_user.id
          if @message.respond_to?(:soft_delete!)
            @message.soft_delete!
          else
            @message.destroy
          end
          render_success(message: 'Deleted successfully')
        else
          render_error(message: 'Not authorized', status: :forbidden)
        end
      end

      private

      def set_conversation
        @conversation = @current_user.conversations.find(params[:conversation_id])
      rescue ActiveRecord::RecordNotFound
        render_error(message: 'Conversation not found', status: :not_found)
      end

      def set_message
        @message = @conversation.messages.find(params[:id])
      end

      def message_params
        params.require(:message).permit(:body, :message_type, :attachment)
      end
    end
  end
end
