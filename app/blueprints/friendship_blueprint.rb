class FriendshipBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :friend_id, :status, :updated_at, :user_id
  end
end
