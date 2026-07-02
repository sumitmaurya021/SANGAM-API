class PostBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :content, :location_name, :visibility, :published, :created_at, :updated_at, :likes_count, :comments_count
    
    field :liked_by_current_user do |post, options|
      options[:current_user].present? ? post.liked_by?(options[:current_user]) : false
    end

    association :user, blueprint: UserBlueprint, view: :normal
  end

  view :extended do
    include_view :normal
    association :comments, blueprint: CommentBlueprint, view: :normal
  end
end
