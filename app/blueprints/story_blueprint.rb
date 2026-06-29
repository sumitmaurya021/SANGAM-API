class StoryBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :caption, :background_color, :text_color, :story_type, :expires_at, :created_at
    association :user, blueprint: UserBlueprint, view: :normal
  end
end
