class ArticleBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :published, :title, :updated_at, :user_id, :views_count
  end
end
