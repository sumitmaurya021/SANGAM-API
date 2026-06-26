class CloseFriendBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :close_friend_id, :created_at, :updated_at, :user_id
  end
end
