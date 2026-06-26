module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_article, only: [:show, :update, :destroy]
      before_action :authorize_article_owner!, only: [:update, :destroy]

      def index
        records = Article.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: ArticleBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: ArticleBlueprint.render_as_hash(@article, view: :normal))
      end

      def create
        record = Article.new(article_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: ArticleBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @article.update(article_params)
          render_success(message: 'Updated successfully', data: ArticleBlueprint.render_as_hash(@article, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @article.errors.messages)
        end
      end

      def destroy
        @article.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def authorize_article_owner!
        unless @article.user_id == @current_user.id || @current_user.super_admin?
          render_error(message: 'Unauthorized', status: :forbidden)
        end
      end

      def article_params
        # Adjust permitted parameters as needed
        params.require(:article).permit(:published, :title, :user_id, :views_count)
      end
    end
  end
end
