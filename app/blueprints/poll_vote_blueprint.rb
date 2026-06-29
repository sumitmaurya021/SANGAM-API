class PollVoteBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :poll_id, :poll_option_id, :updated_at, :user_id
  end
end
