class PostBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :content, :location_name, :visibility, :published, :created_at, :updated_at, :likes_count, :comments_count
    
    field :liked_by_current_user do |post, options|
      options[:current_user].present? ? post.liked_by?(options[:current_user]) : false
    end

    field :image_url do |post, options|
      if post.image.attached?
        host = Rails.application.routes.default_url_options[:host] || 'localhost:3000'
        host = "http://#{host}" unless host.start_with?('http://', 'https://')
        Rails.application.routes.url_helpers.rails_blob_url(post.image, host: host)
      end
    end

    association :user, blueprint: UserBlueprint, view: :normal
    association :poll, blueprint: PollBlueprint, view: :normal
    association :fundraiser, blueprint: FundraiserBlueprint, view: :normal
  end

  view :extended do
    include_view :normal
    association :comments, blueprint: CommentBlueprint, view: :normal
  end
end
