module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_event, only: [:show, :update, :destroy, :respond_to_event]
      before_action :authorize_organizer!, only: [:update, :destroy]

      def index
        records = Event.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: EventBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: EventBlueprint.render_as_hash(@event, view: :normal))
      end

      def create
        record = Event.new(event_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: EventBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @event.update(event_params)
          render_success(message: 'Updated successfully', data: EventBlueprint.render_as_hash(@event, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @event.errors.messages)
        end
      end

      def destroy
        @event.destroy
        render_success(message: 'Deleted successfully')
      end

      def respond_to_event
        response = @event.event_responses.find_or_initialize_by(user_id: @current_user.id)
        response.status = params[:status]

        if response.save
          render_success(message: 'Response recorded', data: response)
        else
          render_error(message: 'Failed to record response', errors: response.errors.messages)
        end
      end

      private

      def set_event
        @event = Event.find(params[:id] || params[:event_id])
      end

      def authorize_organizer!
        unless @event.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def event_params
        # Adjust permitted parameters as needed
        params.require(:event).permit(:cover_image_url, :description, :ends_at, :going_count, :group_id, :interested_count, :location, :organizer_id, :privacy, :reminder_sent, :starts_at, :title)
      end
    end
  end
end
