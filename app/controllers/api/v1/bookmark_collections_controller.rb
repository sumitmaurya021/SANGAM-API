module Api
  module V1
    class BookmarkCollectionsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_bookmark_collection, only: [:show, :update, :destroy, :add_bookmark]
      before_action :authorize_collection!, only: [:update, :destroy, :add_bookmark]

      def index
        records = BookmarkCollection.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: BookmarkCollectionBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: BookmarkCollectionBlueprint.render_as_hash(@bookmark_collection, view: :normal))
      end

      def create
        record = BookmarkCollection.new(bookmark_collection_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: BookmarkCollectionBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @bookmark_collection.update(bookmark_collection_params)
          render_success(message: 'Updated successfully', data: BookmarkCollectionBlueprint.render_as_hash(@bookmark_collection, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @bookmark_collection.errors.messages)
        end
      end

      def destroy
        @bookmark_collection.destroy
        render_success(message: 'Deleted successfully')
      end

      def add_bookmark
        bookmark = Bookmark.find(params[:bookmark_id])
        if bookmark.user_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end
        
        unless @bookmark_collection.bookmarks.include?(bookmark)
          @bookmark_collection.bookmarks << bookmark
        end
        
        render_success(message: 'Bookmark added to collection')
      end

      private

      def set_bookmark_collection
        @bookmark_collection = BookmarkCollection.find(params[:id])
      end

      def authorize_collection!
        unless @bookmark_collection.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def bookmark_collection_params
        # Adjust permitted parameters as needed
        params.require(:bookmark_collection).permit(:cover_item_id, :description, :is_default, :name, :user_id)
      end
    end
  end
end
