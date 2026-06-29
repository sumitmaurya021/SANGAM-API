class PollOptionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :body, :created_at, :poll_id, :position, :updated_at, :votes_count
  end
end
