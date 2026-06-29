class ProfileHighlightBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :emoji, :name, :position, :updated_at, :user_id
  end
end
