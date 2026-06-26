class StoryQaReplyBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :answer, :created_at, :story_id, :updated_at, :user_id
  end
end
