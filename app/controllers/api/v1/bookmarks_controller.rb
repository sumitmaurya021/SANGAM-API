module Api
  module V1
    class BookmarksController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_bookmark, only: [:show, :update, :destroy]

      def index
        records = Bookmark.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: BookmarkBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: BookmarkBlueprint.render_as_hash(@bookmark, view: :normal))
      end

      def create
        record = Bookmark.new(bookmark_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: BookmarkBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @bookmark.update(bookmark_params)
          render_success(message: 'Updated successfully', data: BookmarkBlueprint.render_as_hash(@bookmark, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @bookmark.errors.messages)
        end
      end

      def destroy
        @bookmark.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_bookmark
        @bookmark = Bookmark.find(params[:id])
      end

      def bookmark_params
        # Adjust permitted parameters as needed
        params.require(:bookmark).permit(:bookmark_collection_id, :bookmarkable_id, :bookmarkable_type, :post_id, :user_id)
      end
    end
  end
end
