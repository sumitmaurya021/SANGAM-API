class ReelBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :caption, :music, :music_artist, :music_title, :music_preview_url, :hashtags, :likes_count, :comments_count, :views_count, :created_at

    field :video_url do |reel|
      if reel.video.attached?
        Rails.application.routes.url_helpers.rails_blob_path(reel.video, only_path: true)
      else
        nil
      end
    end

    field :liked_by_current_user do |reel, options|
      options[:current_user].present? ? reel.liked_by?(options[:current_user]) : false
    end

    field :bookmarked_by_current_user do |reel, options|
      options[:current_user].present? ? reel.bookmarked_by?(options[:current_user]) : false
    end

    association :user, blueprint: UserBlueprint, view: :normal
  end
end
