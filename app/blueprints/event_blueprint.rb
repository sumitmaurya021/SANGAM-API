class EventBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :cover_image_url, :created_at, :description, :ends_at, :going_count, :group_id, :interested_count, :location, :organizer_id, :privacy, :reminder_sent, :starts_at, :title, :updated_at
  end
end
