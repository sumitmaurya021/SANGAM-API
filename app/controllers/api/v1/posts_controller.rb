module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_post, only: [:show, :update, :destroy]
      before_action :authorize_post!, only: [:update, :destroy]

      def index
        posts = Post.includes(:user, :comments)
        
        # Filtering
        posts = posts.where(user_id: params[:user_id]) if params[:user_id].present?
        posts = posts.where("content ILIKE ?", "%#{params[:search]}%") if params[:search].present?
        
        # Sorting
        sort_column = params[:sort_by].presence || 'created_at'
        sort_direction = %w[asc desc].include?(params[:sort_dir]) ? params[:sort_dir] : 'desc'
        posts = posts.order("#{sort_column} #{sort_direction}")

        # Pagination
        posts = posts.page(params[:page]).per(params[:per_page] || 20)

        render_success(
          message: 'Posts retrieved successfully',
          data: {
            posts: PostBlueprint.render_as_hash(posts, view: :extended),
            meta: {
              current_page: posts.current_page,
              total_pages: posts.total_pages,
              total_count: posts.total_count
            }
          }
        )
      end

      def show
        render_success(message: 'Post retrieved successfully', data: PostBlueprint.render_as_hash(@post, view: :extended))
      end

      def create
        post = @current_user.posts.build(post_params)
        
        if post.save
          if post.respond_to?(:scheduled_at) && post.scheduled_at.present? && !post.published?
            PublishScheduledPostJob.set(wait_until: post.scheduled_at).perform_later(post.id)
          end
          render_success(message: 'Post created successfully', data: PostBlueprint.render_as_hash(post, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create post', errors: post.errors.messages)
        end
      end

      def update
        if @post.update(post_params.merge(edited_at: Time.current))
          render_success(message: 'Post updated successfully', data: PostBlueprint.render_as_hash(@post, view: :normal))
        else
          render_error(message: 'Failed to update post', errors: @post.errors.messages)
        end
      end

      def destroy
        @post.destroy
        render_success(message: 'Post deleted successfully')
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def authorize_post!
        unless @post.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def post_params
        params.require(:post).permit(
          :content, :image, :visibility, :scheduled_at, :published,
          :link_url, :link_title, :link_description, :link_image_url, :link_domain,
          :location_name, :latitude, :longitude,
          images: [],
          poll_attributes: [
            :question, :ends_at,
            poll_options_attributes: [:body, :position]
          ],
          fundraiser_attributes: [:title, :description, :goal_amount, :currency, :ends_at]
        )
      end
    end
  end
end
