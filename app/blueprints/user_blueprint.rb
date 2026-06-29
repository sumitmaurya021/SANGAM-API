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
