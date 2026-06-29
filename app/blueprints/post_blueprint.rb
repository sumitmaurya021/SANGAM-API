class PostBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :content, :location_name, :visibility, :published, :created_at, :updated_at
    association :user, blueprint: UserBlueprint, view: :normal
  end

  view :extended do
    include_view :normal
    association :comments, blueprint: CommentBlueprint, view: :normal
    # we can add likes logic if needed
  end
end
