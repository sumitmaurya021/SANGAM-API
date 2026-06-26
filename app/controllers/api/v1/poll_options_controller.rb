module Api
  module V1
    class PollOptionsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_poll_option, only: [:show, :update, :destroy]

      def index
        records = PollOption.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: PollOptionBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: PollOptionBlueprint.render_as_hash(@poll_option, view: :normal))
      end

      def create
        record = PollOption.new(poll_option_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: PollOptionBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @poll_option.update(poll_option_params)
          render_success(message: 'Updated successfully', data: PollOptionBlueprint.render_as_hash(@poll_option, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @poll_option.errors.messages)
        end
      end

      def destroy
        @poll_option.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_poll_option
        @poll_option = PollOption.find(params[:id])
      end

      def poll_option_params
        # Adjust permitted parameters as needed
        params.require(:poll_option).permit(:body, :poll_id, :position, :votes_count)
      end
    end
  end
end
