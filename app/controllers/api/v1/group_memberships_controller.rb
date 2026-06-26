module Api
  module V1
    class GroupMembershipsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_group_membership, only: [:show, :update, :destroy]

      def index
        records = GroupMembership.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: GroupMembershipBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: GroupMembershipBlueprint.render_as_hash(@group_membership, view: :normal))
      end

      def create
        record = GroupMembership.new(group_membership_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: GroupMembershipBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @group_membership.update(group_membership_params)
          render_success(message: 'Updated successfully', data: GroupMembershipBlueprint.render_as_hash(@group_membership, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @group_membership.errors.messages)
        end
      end

      def destroy
        @group_membership.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_group_membership
        @group_membership = GroupMembership.find(params[:id])
      end

      def group_membership_params
        # Adjust permitted parameters as needed
        params.require(:group_membership).permit(:group_id, :role, :status, :user_id)
      end
    end
  end
end
