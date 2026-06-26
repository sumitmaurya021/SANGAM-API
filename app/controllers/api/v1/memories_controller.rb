module Api
  module V1
    class MemoriesController < ApplicationController
      before_action :authenticate_request!

      def index
        # Fetch posts from exactly 1 year ago, 2 years ago, etc.
        years_back = (1..5).to_a
        
        memories = @current_user.posts.where(
          "EXTRACT(month FROM created_at) = ? AND EXTRACT(day FROM created_at) = ? AND EXTRACT(year FROM created_at) IN (?)",
          Time.current.month,
          Time.current.day,
          years_back.map { |y| Time.current.year - y }
        ).includes(:user, :comments)

        render_success(
          message: 'Memories retrieved successfully',
          data: PostBlueprint.render_as_hash(memories, view: :normal)
        )
      end
    end
  end
end
