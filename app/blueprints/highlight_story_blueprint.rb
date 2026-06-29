class HighlightStoryBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :position, :profile_highlight_id, :story_id, :updated_at
  end
end
