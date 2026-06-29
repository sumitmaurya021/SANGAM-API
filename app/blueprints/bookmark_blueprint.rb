class BookmarkBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :bookmark_collection_id, :bookmarkable_id, :bookmarkable_type, :created_at, :post_id, :updated_at, :user_id
  end
end
