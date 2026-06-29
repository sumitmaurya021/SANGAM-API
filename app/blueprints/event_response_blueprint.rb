class EventResponseBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :event_id, :response, :updated_at, :user_id
  end
end
