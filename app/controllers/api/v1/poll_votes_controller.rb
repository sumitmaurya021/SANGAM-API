module Api
  module V1
    class PollVotesController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_poll_vote, only: [:show, :update, :destroy]

      def index
        records = PollVote.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: PollVoteBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: PollVoteBlueprint.render_as_hash(@poll_vote, view: :normal))
      end

      def create
        record = PollVote.new(poll_vote_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: PollVoteBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @poll_vote.update(poll_vote_params)
          render_success(message: 'Updated successfully', data: PollVoteBlueprint.render_as_hash(@poll_vote, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @poll_vote.errors.messages)
        end
      end

      def destroy
        @poll_vote.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_poll_vote
        @poll_vote = PollVote.find(params[:id])
      end

      def poll_vote_params
        # Adjust permitted parameters as needed
        params.require(:poll_vote).permit(:poll_id, :poll_option_id, :user_id)
      end
    end
  end
end
