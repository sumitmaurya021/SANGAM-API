module Api
  module V1
    class EventResponsesController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_event_response, only: [:show, :update, :destroy]

      def index
        records = EventResponse.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: EventResponseBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: EventResponseBlueprint.render_as_hash(@event_response, view: :normal))
      end

      def create
        record = EventResponse.new(event_response_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: EventResponseBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @event_response.update(event_response_params)
          render_success(message: 'Updated successfully', data: EventResponseBlueprint.render_as_hash(@event_response, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @event_response.errors.messages)
        end
      end

      def destroy
        @event_response.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_event_response
        @event_response = EventResponse.find(params[:id])
      end

      def event_response_params
        # Adjust permitted parameters as needed
        params.require(:event_response).permit(:event_id, :response, :user_id)
      end
    end
  end
end
