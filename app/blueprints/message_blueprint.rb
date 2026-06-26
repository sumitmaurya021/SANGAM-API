class MessageBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :body, :conversation_id, :created_at, :deleted, :message_type, :read_at, :updated_at, :user_id
  end
end
