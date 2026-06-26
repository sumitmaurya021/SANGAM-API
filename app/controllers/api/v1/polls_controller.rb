module Api
  module V1
    class PollsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_poll, only: [:show, :update, :destroy, :vote]

      def index
        records = Poll.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: PollBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: PollBlueprint.render_as_hash(@poll, view: :normal))
      end

      def create
        record = Poll.new(poll_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: PollBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @poll.update(poll_params)
          render_success(message: 'Updated successfully', data: PollBlueprint.render_as_hash(@poll, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @poll.errors.messages)
        end
      end

      def destroy
        @poll.destroy
        render_success(message: 'Deleted successfully')
      end

      def vote
        option_id = params[:option_id]
        option = @poll.poll_options.find_by(id: option_id)
        
        if option.nil?
          return respond_with_error('Invalid option')
        end

        if @poll.expires_at.present? && @poll.expires_at < Time.current
          return respond_with_error('Poll has expired')
        end

        existing_vote = @poll.poll_votes.find_by(user_id: @current_user.id)
        if existing_vote
          return respond_with_error('You have already voted')
        end

        vote = @poll.poll_votes.build(user_id: @current_user.id, poll_option_id: option.id)
        if vote.save
          render_success(message: 'Vote cast successfully', data: poll_results_json)
        else
          render_error(message: 'Failed to cast vote', errors: vote.errors.messages)
        end
      end

      private

      def set_poll
        @poll = Poll.find(params[:id])
      end

      def respond_with_error(msg)
        render_error(message: msg, status: :bad_request)
      end

      def poll_results_json
        {
          id: @poll.id,
          total_votes: @poll.poll_votes.count,
          options: @poll.poll_options.map do |opt|
            {
              id: opt.id,
              text: opt.option_text,
              votes_count: opt.poll_votes.count
            }
          end
        }
      end

      def poll_params
        # Adjust permitted parameters as needed
        params.require(:poll).permit(:ends_at, :expired, :post_id, :question)
      end
    end
  end
end
