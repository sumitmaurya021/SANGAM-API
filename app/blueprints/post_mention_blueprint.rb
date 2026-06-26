class PostMentionBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :mentionable_id, :mentionable_type, :post_id, :updated_at, :user_id
  end
end
