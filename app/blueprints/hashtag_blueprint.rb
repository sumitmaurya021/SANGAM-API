class HashtagBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :name, :posts_count, :updated_at
  end
end
