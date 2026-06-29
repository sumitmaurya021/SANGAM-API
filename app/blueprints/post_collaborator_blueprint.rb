class PostCollaboratorBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :post_id, :status, :updated_at, :user_id
  end
end
