module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        users = User.all
        users = users.where("name ILIKE ? OR email ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
        users = users.page(params[:page]).per(params[:per_page] || 20)

        render_success(
          message: 'Users retrieved successfully',
          data: {
            users: UserBlueprint.render_as_hash(users, view: :normal),
            meta: {
              current_page: users.current_page,
              total_pages: users.total_pages,
              total_count: users.total_count
            }
          }
        )
      end

      def show
        render_success(message: 'User retrieved successfully', data: UserBlueprint.render_as_hash(@user, view: :extended))
      end

      def update
        if @user.id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        if @user.update(user_params)
          render_success(message: 'User updated successfully', data: UserBlueprint.render_as_hash(@user, view: :extended))
        else
          render_error(message: 'Failed to update user', errors: @user.errors.messages)
        end
      end

      def destroy
        if @user.id != @current_user.id && !@current_user.super_admin?
          return render_error(message: 'Unauthorized', status: :forbidden)
        end

        @user.destroy
        render_success(message: 'User deleted successfully')
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :bio, :birthday, :avatar, :cover_photo, :dark_mode, :location, :website_url)
      end
    end
  end
end
