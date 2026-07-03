module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_conversation, only: [:show, :update, :destroy]

      def index
        records = Conversation.involving(@current_user).recent.to_a
        seen_peers = []
        deduplicated = records.select do |conv|
          peer_id = conv.sender_id == @current_user.id ? conv.recipient_id : conv.sender_id
          if seen_peers.include?(peer_id)
            false
          else
            seen_peers.push(peer_id)
            true
          end
        end

        # Paginate manual array
        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || 20).to_i
        offset = (page - 1) * per_page
        paginated = deduplicated[offset, per_page] || []

        render_success(message: 'Retrieved successfully', data: ConversationBlueprint.render_as_hash(paginated, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: ConversationBlueprint.render_as_hash(@conversation, view: :normal))
      end

      def create
        recipient_id = conversation_params[:recipient_id]
        if recipient_id.blank?
          return render_error(message: 'Recipient ID is required')
        end

        # Check if conversation already exists
        recipient = User.find_by(id: recipient_id)
        if recipient.nil?
          return render_error(message: 'Recipient user not found')
        end

        existing = Conversation.between(@current_user, recipient)
        if existing
          return render_success(message: 'Retrieved existing conversation', data: ConversationBlueprint.render_as_hash(existing, view: :normal))
        end

        record = Conversation.new(conversation_params)
        record.sender_id = @current_user.id

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
