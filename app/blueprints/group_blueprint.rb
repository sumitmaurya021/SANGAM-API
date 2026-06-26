class GroupBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :description, :members_count, :name, :owner_id, :posts_count, :privacy, :updated_at
  end
end
