class CategoryTagBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :name, :slug, :updated_at
  end
end
