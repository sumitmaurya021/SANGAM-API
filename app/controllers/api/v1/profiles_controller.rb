module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_user, only: [:show, :friends, :followers, :following]

      def show
        render_success(
          message: 'Profile retrieved',
          data: {
            user: UserBlueprint.render_as_hash(@user, view: :extended),
            friends_count: @user.all_friends.count,
            followers_count: @user.followers.count,
            following_count: @user.following.count
          }
        )
      end

      def friends
        friends = @user.all_friends
        # Pagination
        page = params[:page] || 1
        per_page = params[:per_page] || 20
        paginated_friends = Kaminari.paginate_array(friends).page(page).per(per_page)

        render_success(message: 'Friends retrieved', data: UserBlueprint.render_as_hash(paginated_friends, view: :normal))
      end

      def followers
        followers = @user.followers.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Followers retrieved', data: UserBlueprint.render_as_hash(followers, view: :normal))
      end

      def following
        following = @user.following.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Following retrieved', data: UserBlueprint.render_as_hash(following, view: :normal))
      end

      def friends_list
        friends = @current_user.all_friends
        render_success(message: 'Friends list retrieved', data: UserBlueprint.render_as_hash(friends, view: :normal))
      end

      def search
        query = params[:q].to_s.strip
        if query.length < 2
          return render_success(message: 'Search query too short', data: [])
        end

        users = User.where.not(id: @current_user.id)
                    .where("name ILIKE :q OR email ILIKE :q", q: "%#{query}%")
                    .order(:name)
                    .limit(8)

        results = users.map do |u|
          status = if @current_user.friends_with?(u)
                     "friends"
                   elsif @current_user.sent_friend_requests.exists?(friend_id: u.id)
                     "request_sent"
                   elsif @current_user.pending_friend_requests.exists?(user_id: u.id)
                     "request_received"
                   else
                     "none"
                   end

          friendship = @current_user.friendships.find_by(friend_id: u.id) ||
                       u.friendships.find_by(friend_id: @current_user.id)

          {
            user: UserBlueprint.render_as_hash(u, view: :normal),
            friendship_status: status,
            friendship_id: friendship&.id,
            mutual_friends_count: (@current_user.all_friends & u.all_friends).count
          }
        end

        render_success(message: 'Profile search completed', data: results)
      end

      def toggle_dark_mode
        dark_mode = params[:dark_mode] == true || params[:dark_mode] == "true"
        @current_user.update_column(:dark_mode, dark_mode)
        render_success(message: 'Dark mode toggled', data: { dark_mode: @current_user.dark_mode })
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
