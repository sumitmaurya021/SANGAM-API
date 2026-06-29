module Api
  module V1
    module Admin
      class DashboardController < ApplicationController
        before_action :authenticate_request!
        before_action :authorize_super_admin!

        def index
          # Overall Statistics
          total_users       = User.count
          total_posts       = Post.count
          total_likes       = Like.count
          total_comments    = Comment.count
          total_shares      = Share.count
          total_friendships = Friendship.where(status: 'accepted').count
          total_reels       = Reel.count
          total_stories     = Story.count
          total_groups      = Group.count
          total_events      = Event.count

          # Recent Activity
          recent_users = User.order(created_at: :desc).limit(8)
          recent_posts = Post.includes(:user).order(created_at: :desc).limit(8)

          # Top Users
          top_posters = User.left_joins(:posts).group('users.id').order('COUNT(posts.id) DESC').limit(8).select('users.*, COUNT(posts.id) as posts_count')
          top_likers = User.left_joins(:likes).group('users.id').order('COUNT(likes.id) DESC').limit(8).select('users.*, COUNT(likes.id) as likes_count')
          top_commenters = User.left_joins(:comments).group('users.id').order('COUNT(comments.id) DESC').limit(8).select('users.*, COUNT(comments.id) as comments_count')

          # Growth Statistics (Last 30 days)
          users_last_30_days  = User.where('created_at >= ?', 30.days.ago).count
          posts_last_30_days  = Post.where('created_at >= ?', 30.days.ago).count
          likes_last_30_days  = Like.where('created_at >= ?', 30.days.ago).count
          comments_last_30_days = Comment.where('created_at >= ?', 30.days.ago).count

          # Chart: last 7 days daily activity
          six_days_ago = 6.days.ago.beginning_of_day
          daily_users = User.where('created_at >= ?', six_days_ago).pluck(:created_at).group_by(&:to_date).transform_values(&:size)
          daily_posts = Post.where('created_at >= ?', six_days_ago).pluck(:created_at).group_by(&:to_date).transform_values(&:size)
          daily_likes = Like.where('created_at >= ?', six_days_ago).pluck(:created_at).group_by(&:to_date).transform_values(&:size)

          date_range = (6.days.ago.to_date..Date.today)
          chart_labels = date_range.map { |d| d.strftime('%b %d') }
          chart_users  = date_range.map { |d| daily_users[d] || 0 }
          chart_posts  = date_range.map { |d| daily_posts[d] || 0 }
          chart_likes  = date_range.map { |d| daily_likes[d] || 0 }

          donut_data = [total_posts, total_likes, total_comments, total_shares]

          # Engagement
          users_with_posts    = User.joins(:posts).distinct.count
          users_with_likes    = User.joins(:likes).distinct.count
          users_with_comments = User.joins(:comments).distinct.count
          users_with_friends  = User.joins(:friendships).where(friendships: { status: 'accepted' }).distinct.count

          # Averages
          avg_posts_per_user    = total_users > 0 ? (total_posts.to_f / total_users).round(1) : 0
          avg_likes_per_post    = total_posts > 0 ? (total_likes.to_f / total_posts).round(1) : 0
          avg_comments_per_post = total_posts > 0 ? (total_comments.to_f / total_posts).round(1) : 0

          stats = {
            overall_statistics: {
              total_users: total_users,
              total_posts: total_posts,
              total_likes: total_likes,
              total_comments: total_comments,
              total_shares: total_shares,
              total_friendships: total_friendships,
              total_reels: total_reels,
              total_stories: total_stories,
              total_groups: total_groups,
              total_events: total_events
            },
            recent_activity: {
              recent_users: UserBlueprint.render_as_hash(recent_users, view: :normal),
              recent_posts: PostBlueprint.render_as_hash(recent_posts, view: :normal)
            },
            top_users: {
              top_posters: top_posters.map { |u| { id: u.id, name: u.name, count: u.posts_count } },
              top_likers: top_likers.map { |u| { id: u.id, name: u.name, count: u.likes_count } },
              top_commenters: top_commenters.map { |u| { id: u.id, name: u.name, count: u.comments_count } }
            },
            growth_statistics: {
              users_last_30_days: users_last_30_days,
              posts_last_30_days: posts_last_30_days,
              likes_last_30_days: likes_last_30_days,
              comments_last_30_days: comments_last_30_days
            },
            chart_data: {
              labels: chart_labels,
              users: chart_users,
              posts: chart_posts,
              likes: chart_likes,
              donut_data: donut_data
            },
            engagement: {
              users_with_posts: users_with_posts,
              users_with_likes: users_with_likes,
              users_with_comments: users_with_comments,
              users_with_friends: users_with_friends
            },
            averages: {
              avg_posts_per_user: avg_posts_per_user,
              avg_likes_per_post: avg_likes_per_post,
              avg_comments_per_post: avg_comments_per_post
            }
          }

          render_success(message: 'Admin stats retrieved', data: stats)
        end

        def users
          users = User.all.page(params[:page]).per(params[:per_page] || 20)
          render_success(message: 'Users retrieved', data: UserBlueprint.render_as_hash(users, view: :normal))
        end

        def posts
          posts = Post.includes(:user).all.page(params[:page]).per(params[:per_page] || 20)
          render_success(message: 'Posts retrieved', data: PostBlueprint.render_as_hash(posts, view: :normal))
        end

        def user_details
          user = User.find(params[:id])
          render_success(message: 'User details retrieved', data: UserBlueprint.render_as_hash(user, view: :extended))
        end

        private

        def authorize_super_admin!
          unless @current_user.super_admin?
            render_error(message: 'Unauthorized. Super Admin only.', status: :forbidden)
          end
        end
      end
    end
  end
end
