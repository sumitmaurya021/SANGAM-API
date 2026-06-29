class NotificationBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :actor_id, :created_at, :message, :notifiable_id, :notifiable_type, :notification_type, :read_at, :recipient_id, :updated_at
  end
end
