module Api
  module V1
    class CategoryTagsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_category_tag, only: [:show, :update, :destroy]

      def index
        records = CategoryTag.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: CategoryTagBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: CategoryTagBlueprint.render_as_hash(@category_tag, view: :normal))
      end

      def create
        record = CategoryTag.new(category_tag_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: CategoryTagBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @category_tag.update(category_tag_params)
          render_success(message: 'Updated successfully', data: CategoryTagBlueprint.render_as_hash(@category_tag, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @category_tag.errors.messages)
        end
      end

      def destroy
        @category_tag.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_category_tag
        @category_tag = CategoryTag.find(params[:id])
      end

      def category_tag_params
        # Adjust permitted parameters as needed
        params.require(:category_tag).permit(:name, :slug)
      end
    end
  end
end
