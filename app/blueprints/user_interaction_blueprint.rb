class UserInteractionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :interaction_type, :post_id, :updated_at, :user_id
  end
end
