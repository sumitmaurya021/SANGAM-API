require 'fileutils'

models = %w[
  Group GroupMembership Event EventResponse Fundraiser MarketplaceListing
  Friendship Follow CloseFriend Conversation Message GroupChat GroupChatMessage
  Notification Article Bookmark BookmarkCollection Poll PollOption PollVote
  Hashtag CategoryTag ProfileHighlight
]

models.each do |model_name|
  controller_name = model_name.tableize
  class_name = controller_name.camelize
  model_class = model_name.camelize
  
  content = <<~RUBY
    module Api
      module V1
        class #{class_name}Controller < ApplicationController
          before_action :authenticate_request!, except: [:index, :show]
          before_action :set_#{model_name.underscore}, only: [:show, :update, :destroy]

          def index
            records = #{model_class}.all.page(params[:page]).per(params[:per_page] || 20)
            render_success(message: 'Retrieved successfully', data: records)
          end

          def show
            render_success(message: 'Retrieved successfully', data: @#{model_name.underscore})
          end

          def create
            record = #{model_class}.new(#{model_name.underscore}_params)
            # Assign user if user_id exists
            record.user_id = @current_user.id if record.respond_to?(:user_id=)

            if record.save
              render_success(message: 'Created successfully', data: record, status: :created)
            else
              render_error(message: 'Failed to create', errors: record.errors.messages)
            end
          end

          def update
            if @#{model_name.underscore}.update(#{model_name.underscore}_params)
              render_success(message: 'Updated successfully', data: @#{model_name.underscore})
            else
              render_error(message: 'Failed to update', errors: @#{model_name.underscore}.errors.messages)
            end
          end

          def destroy
            @#{model_name.underscore}.destroy
            render_success(message: 'Deleted successfully')
          end

          private

          def set_#{model_name.underscore}
            @#{model_name.underscore} = #{model_class}.find(params[:id])
          end

          def #{model_name.underscore}_params
            # Adjust permitted parameters as needed
            params.require(:#{model_name.underscore}).permit!
          end
        end
      end
    end
  RUBY

  file_path = "app/controllers/api/v1/#{controller_name}_controller.rb"
  File.write(file_path, content)
  puts "Created #{file_path}"
end
