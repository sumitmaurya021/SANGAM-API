class PollBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :ends_at, :expired, :post_id, :question, :updated_at
    association :poll_options, blueprint: PollOptionBlueprint, view: :normal
  end
end
