class ReelBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :caption, :music, :music_artist, :hashtags, :created_at
    association :user, blueprint: UserBlueprint, view: :normal
  end
end
