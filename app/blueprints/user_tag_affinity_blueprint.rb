class UserTagAffinityBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :category_tag_id, :created_at, :score, :updated_at, :user_id
  end
end
