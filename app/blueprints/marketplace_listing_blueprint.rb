class MarketplaceListingBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :category, :condition, :created_at, :description, :location_name, :price, :price_negotiable, :status, :title, :updated_at, :user_id, :views_count
  end
end
