class ReelLikeBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :reaction_type, :reel_id, :updated_at, :user_id
  end
end
