class GroupMembershipBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :group_id, :role, :status, :updated_at, :user_id
  end
end
