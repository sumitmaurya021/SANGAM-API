class CommentBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :content, :created_at, :parent_id, :replied_to_user_id, :updated_at
    association :user, blueprint: UserBlueprint, view: :normal
    association :replied_to_user, blueprint: UserBlueprint, view: :normal
  end
end
