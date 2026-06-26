module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_request!, except: [:index, :show]
      before_action :set_notification, only: [:show, :update, :destroy, :mark_read]

      def index
        records = Notification.all.page(params[:page]).per(params[:per_page] || 20)
        render_success(message: 'Retrieved successfully', data: NotificationBlueprint.render_as_hash(records, view: :normal))
      end

      def show
        render_success(message: 'Retrieved successfully', data: NotificationBlueprint.render_as_hash(@notification, view: :normal))
      end

      def dropdown
        notifications = @current_user.notifications
                                     .includes(:actor)
                                     .order(created_at: :desc)
                                     .limit(10)
        
        unread_count = @current_user.notifications.where(read_at: nil).count

        render_success(
          message: 'Dropdown notifications retrieved',
          data: {
            notifications: NotificationBlueprint.render_as_hash(notifications, view: :normal),
            unread_count: unread_count
          }
        )
      end

      def create
        record = Notification.new(notification_params)
        # Assign user if user_id exists
        record.user_id = @current_user.id if record.respond_to?(:user_id=)

        if record.save
          render_success(message: 'Created successfully', data: NotificationBlueprint.render_as_hash(record, view: :normal), status: :created)
        else
          render_error(message: 'Failed to create', errors: record.errors.messages)
        end
      end

      def update
        if @notification.update(notification_params)
          render_success(message: 'Updated successfully', data: NotificationBlueprint.render_as_hash(@notification, view: :normal))
        else
          render_error(message: 'Failed to update', errors: @notification.errors.messages)
        end
      end

      def mark_read
        if @notification.recipient_id != @current_user.id
          return render_error(message: 'Unauthorized', status: :forbidden)
        end
        
        @notification.update(read_at: Time.current)
        render_success(message: 'Notification marked as read')
      end

      def mark_all_read
        @current_user.notifications.where(read_at: nil).update_all(read_at: Time.current)
        render_success(message: 'All notifications marked as read')
      end

      def destroy
        @notification.destroy
        render_success(message: 'Deleted successfully')
      end

      private

      def set_notification
        @notification = Notification.find(params[:id])
      end

      def notification_params
        # Adjust permitted parameters as needed
        params.require(:notification).permit(:actor_id, :message, :notifiable_id, :notifiable_type, :notification_type, :read_at, :recipient_id)
      end
    end
  end
end
