module Api
  module V1
    class SettingsController < ApplicationController
      before_action :authenticate_request!

      def toggle_dark_mode
        @current_user.update_column(:dark_mode, !@current_user.dark_mode)
        render_success(message: 'Dark mode toggled', data: { dark_mode: @current_user.dark_mode })
      end
    end
  end
end
