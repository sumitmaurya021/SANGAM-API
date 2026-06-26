class GroupChatBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :description, :members_count, :name, :owner_id, :updated_at
  end
end
