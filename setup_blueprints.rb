require 'fileutils'

FileUtils.mkdir_p 'app/blueprints'

user_blueprint = <<~RUBY
class UserBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :name, :email, :bio, :website_url, :location, :verified, :online_status, :created_at
    # Avoid exposing password_digest, otp_secret, etc.
  end

  view :extended do
    include_view :normal
    fields :followers_count, :following_count
  end
end
RUBY

post_blueprint = <<~RUBY
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
RUBY

comment_blueprint = <<~RUBY
class CommentBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :content, :created_at
    association :user, blueprint: UserBlueprint, view: :normal
  end
end
RUBY

story_blueprint = <<~RUBY
class StoryBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :caption, :background_color, :text_color, :story_type, :expires_at, :created_at
    association :user, blueprint: UserBlueprint, view: :normal
  end
end
RUBY

reel_blueprint = <<~RUBY
class ReelBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :caption, :music, :music_artist, :hashtags, :created_at
    association :user, blueprint: UserBlueprint, view: :normal
  end
end
RUBY

File.write('app/blueprints/user_blueprint.rb', user_blueprint)
File.write('app/blueprints/post_blueprint.rb', post_blueprint)
File.write('app/blueprints/comment_blueprint.rb', comment_blueprint)
File.write('app/blueprints/story_blueprint.rb', story_blueprint)
File.write('app/blueprints/reel_blueprint.rb', reel_blueprint)
puts "Blueprints created."
