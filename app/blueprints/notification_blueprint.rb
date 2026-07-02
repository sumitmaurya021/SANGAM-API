class NotificationBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :actor_id, :created_at, :message, :notifiable_id, :notifiable_type, :notification_type, :read_at, :recipient_id, :updated_at
    
    field :friendship_id do |notification|
      notification.notifiable.is_a?(Friendship) ? notification.notifiable_id : nil
    end

    field :friendship_accepted do |notification|
      notification.notifiable.is_a?(Friendship) ? (notification.notifiable.status == 'accepted') : false
    end

    field :read do |notification|
      notification.read?
    end
  end
end
