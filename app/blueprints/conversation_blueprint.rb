class ConversationBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :last_message_at, :recipient_id, :sender_id, :updated_at
  end
end
