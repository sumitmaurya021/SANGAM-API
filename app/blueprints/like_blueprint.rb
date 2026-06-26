class LikeBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :post_id, :reaction_type, :updated_at, :user_id
  end
end
