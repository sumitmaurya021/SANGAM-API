class FollowBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :created_at, :followee_id, :follower_id, :updated_at
  end
end
