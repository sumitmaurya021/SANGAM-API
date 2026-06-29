module Api
  module V1
    class MarketplaceListingsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_marketplace_listing, only: [:show, :update, :destroy, :mark_sold]
      before_action :authorize_listing!, only: [:update, :destroy, :mark_sold]

      def index
        records = MarketplaceListing.all

        records = records.by_category(params[:category]) if params[:category].present?
        records = records.search(params[:q])             if params[:q].present?

        if params[:min_price].present?
          records = records.where('price >= ?', params[:min_price].to_f)
        end
        if params[:max_price].present?
          records = records.where('price <= ?', params[:max_price].to_f)
        end

        records = records.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: MarketplaceListingBlueprint.render_as_hash(records, view: :normal))
      end

      def my_listings
        records = @current_user.marketplace_listings.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'My listings retrieved successfully', data: MarketplaceListingBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        @marketplace_listing.increment!(:views_count) if @marketplace_listing.respond_to?(:views_count)
        render_success(message: 'Retrieved successfully', data: MarketplaceListingBlueprint.render_as_hash(@marketplace_listing, view: :normal))
      end

      def create
        record = @current_user.marketplace_listings.build(marketplace_listing_params)

        if record.save
          render_success(message: 'Created successfully', data: MarketplaceListingBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @marketplace_listing.update(marketplace_listing_params)
          render_success(message: 'Updated successfully', data: MarketplaceListingBlueprint.render_as_hash(@marketplace_listing, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @marketplace_listing.errors.messages)
        end
      end

      def destroy
        @marketplace_listing.destroy
        render_success(message: 'Deleted successfully')
      end

      def mark_sold
        if @marketplace_listing.respond_to?(:mark_sold!)
          @marketplace_listing.mark_sold!
          render_success(message: 'Marked as sold', data: MarketplaceListingBlueprint.render_as_hash(@marketplace_listing, view: :normal))
        elsif @marketplace_listing.update(status: 'sold')
          render_success(message: 'Marked as sold', data: MarketplaceListingBlueprint.render_as_hash(@marketplace_listing, view: :normal))
        else
          render_error(message: 'Failed to update status', errors: @marketplace_listing.errors.messages)
        end
      end

      private

      def set_marketplace_listing
        @marketplace_listing = MarketplaceListing.find(params[:id])
      end

      def authorize_listing!
        unless @marketplace_listing.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def marketplace_listing_params
        # Adjust permitted parameters as needed
        params.require(:marketplace_listing).permit(:category, :condition, :description, :location_name, :price, :price_negotiable, :status, :title, :user_id, :views_count, images: [])
      end
    end
  end
end
