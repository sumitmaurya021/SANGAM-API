class PollBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :ends_at, :expired, :post_id, :question, :updated_at
  end
end
