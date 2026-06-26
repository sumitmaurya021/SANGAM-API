class BookmarkCollectionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :cover_item_id, :created_at, :description, :is_default, :name, :updated_at, :user_id
  end
end
