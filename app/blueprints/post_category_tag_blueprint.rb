class PostCategoryTagBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :category_tag_id, :confidence_score, :created_at, :post_id, :updated_at
  end
end
