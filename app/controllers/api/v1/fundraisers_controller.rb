module Api
  module V1
    class FundraisersController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_fundraiser, only: [:show, :update, :destroy, :donate]

      def index
        records = Fundraiser.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: FundraiserBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: FundraiserBlueprint.render_as_hash(@fundraiser, view: :normal))
      end

      def create
        record = Fundraiser.new(fundraiser_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: FundraiserBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @fundraiser.update(fundraiser_params)
          render_success(message: 'Updated successfully', data: FundraiserBlueprint.render_as_hash(@fundraiser, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @fundraiser.errors.messages)
        end
      end

      def destroy
        @fundraiser.destroy
        render_success(message: 'Deleted successfully')
      end

      def donate
        amount = params[:amount].to_f
        if amount <= 0
          return render_error(message: 'Amount must be greater than 0', status: :bad_request)
        end
        
        # In a real scenario, this would integrate with Stripe/PayPal.
        # For this API, we will just simulate the donation increment.
        @fundraiser.increment!(:amount_raised, amount)
        render_success(message: 'Donation successful', data: FundraiserBlueprint.render_as_hash(@fundraiser, view: :normal))
      end

      private

      def set_fundraiser
        @fundraiser = Fundraiser.find(params[:id])
      end

      def fundraiser_params
        # Adjust permitted parameters as needed
        params.require(:fundraiser).permit(:currency, :description, :ends_at, :goal_amount, :post_id, :raised_amount, :status, :title)
      end
    end
  end
end
