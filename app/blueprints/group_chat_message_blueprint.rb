class GroupChatMessageBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :body, :created_at, :deleted, :group_chat_id, :message_type, :updated_at, :user_id
  end
end
