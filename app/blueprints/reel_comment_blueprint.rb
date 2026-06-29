class ReelCommentBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :content, :created_at, :parent_id, :reel_id, :replies_count, :updated_at, :user_id
  end
end
