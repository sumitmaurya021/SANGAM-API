class GroupChatMemberBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :group_chat_id, :role, :updated_at, :user_id
  end
end
