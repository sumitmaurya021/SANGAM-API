module Api
  class HomesController < Api::ApplicationController
    skip_before_action :doorkeeper_authorize!, only: [:index]
    
    def index
      render json: { message: 'Welcome to the Sangam API' }
    end
  end
end
