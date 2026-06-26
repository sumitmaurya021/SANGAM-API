module Api
  module V1
    class GroupsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_group, only: [:show, :update, :destroy, :join, :leave, :approve_member, :remove_member]
      before_action :authorize_admin!, only: [:update, :destroy, :approve_member, :remove_member]

      def index
        groups = Group.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Groups retrieved successfully', data: groups) # Consider GroupBlueprint here later
      end

      def show
        render_success(message: 'Group retrieved successfully', data: GroupBlueprint.render_as_hash(@group, view: :normal))
      end

      def create
        group = Group.new(group_params)
        group.owner = @current_user
        
        if group.save
          # Creator is automatically an admin member
          GroupMembership.create!(group: group, user: @current_user, role: 'admin', status: 'active')
          render_success(message: 'Group created successfully', data: GroupBlueprint.render_as_hash(group, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create group', errors: group.errors.messages)
        end
      end

      def update
        if @group.update(group_params)
          render_success(message: 'Group updated successfully', data: GroupBlueprint.render_as_hash(@group, view: :normal))
        else
          render_error(message: 'Failed to update group', errors: @group.errors.messages)
        end
      end

      def destroy
        @group.destroy
        render_success(message: 'Group deleted successfully')
      end

      def join
        membership = @group.group_memberships.find_or_initialize_by(user: @current_user)
        
        if membership.persisted?
          return render_error(message: 'You have already requested to join or are a member')
        end

        # If group is public, maybe auto-approve, else pending
        membership.status = @group.privacy == 'public' ? 'active' : 'pending'
        membership.role = 'member'

        if membership.save
          render_success(message: "Successfully joined or requested to join", data: membership)
        else
          render_error(message: 'Failed to join group', errors: membership.errors.messages)
        end
      end

      def leave
        membership = @group.group_memberships.find_by(user: @current_user)
        if membership&.destroy
          render_success(message: 'Left group successfully')
        else
          render_error(message: 'You are not a member of this group', status: :not_found)
        end
      end

      def approve_member
        membership = @group.group_memberships.find_by(user_id: params[:user_id])
        return render_error(message: 'Membership not found', status: :not_found) unless membership

        if membership.update(status: 'approved')
          render_success(message: 'Member approved', data: membership)
        else
          render_error(message: 'Failed to approve member', errors: membership.errors.messages)
        end
      end

      def remove_member
        membership = @group.group_memberships.find_by(user_id: params[:user_id])
        return render_error(message: 'Membership not found', status: :not_found) unless membership

        membership.destroy
        render_success(message: 'Member removed')
      end

      private

      def set_group
        @group = Group.find(params[:id])
      end

      def authorize_admin!
        membership = @group.group_memberships.find_by(user: @current_user)
        unless membership&.role == 'admin' || @current_user.super_admin?
          render_error(message: 'Unauthorized. Admins only.', status: :forbidden)
        end
      end

      def group_params
        params.require(:group).permit(:name, :description, :privacy, :cover_photo)
      end
    end
  end
end
