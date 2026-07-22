class ArticleBlueprint < Blueprinter::Base
  identifier :id

  association :user, blueprint: UserBlueprint, view: :normal

  view :normal do
    fields :created_at, :published, :title, :updated_at, :user_id, :views_count
    field :content_text, name: :body do |article|
      article.content.respond_to?(:body) ? article.content.body.to_plain_text : article.content.to_s
    end
    field :content_text, name: :content do |article|
      article.content.respond_to?(:body) ? article.content.body.to_plain_text : article.content.to_s
    end
  end
end
