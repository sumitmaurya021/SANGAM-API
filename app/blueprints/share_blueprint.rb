class ShareBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :post_id, :updated_at, :user_id
  end
end
