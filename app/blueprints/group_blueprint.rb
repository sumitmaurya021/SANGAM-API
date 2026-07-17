class GroupBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :description, :members_count, :name, :owner_id, :posts_count, :privacy, :updated_at
    association :group_memberships, name: :memberships, blueprint: GroupMembershipBlueprint
  end
end
