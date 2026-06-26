class StoryPollVoteBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :option, :story_id, :updated_at, :user_id
  end
end
