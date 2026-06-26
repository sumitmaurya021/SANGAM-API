class PostHashtagBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :hashtag_id, :post_id, :updated_at
  end
end
