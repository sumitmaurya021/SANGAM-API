module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_conversation, only: [:show, :update, :destroy]

      def index
        records = Conversation.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: ConversationBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: ConversationBlueprint.render_as_hash(@conversation, view: :normal))
      end

      def create
        record = Conversation.new(conversation_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: ConversationBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @conversation.update(conversation_params)
          render_success(message: 'Updated successfully', data: ConversationBlueprint.render_as_hash(@conversation, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @conversation.errors.messages)
        end
      end

      def destroy
        @conversation.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_conversation
        @conversation = Conversation.find(params[:id])
      end

      def conversation_params
        # Adjust permitted parameters as needed
        params.require(:conversation).permit(:last_message_at, :recipient_id, :sender_id)
      end
    end
  end
end
