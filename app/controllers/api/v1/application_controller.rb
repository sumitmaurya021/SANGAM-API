module Api
  module V1
    class ApplicationController < ::ApplicationController
      include JwtAuthenticable
      include Authorization
    end
  end
end
