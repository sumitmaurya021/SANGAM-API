class CommentBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :content, :created_at
    association :user, blueprint: UserBlueprint, view: :normal
  end
end
