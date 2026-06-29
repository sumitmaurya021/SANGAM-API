module Api
  module V1
    class LinkPreviewsController < ApplicationController
      before_action :authenticate_request!

      def show
        url = params[:url]
        return render_error(message: 'URL is required', status: :bad_request) if url.blank?

        begin
          require 'net/http'
          require 'nokogiri'
          
          uri = URI.parse(url)
          response = Net::HTTP.get_response(uri)
          
          if response.is_a?(Net::HTTPSuccess)
            doc = Nokogiri::HTML(response.body)
            
            title = doc.at('meta[property="og:title"]')&.[]('content') || doc.at('title')&.text
            description = doc.at('meta[property="og:description"]')&.[]('content') || doc.at('meta[name="description"]')&.[]('content')
            image = doc.at('meta[property="og:image"]')&.[]('content')
            
            preview_data = {
              url: url,
              title: title,
              description: description,
              image: image
            }
            render_success(message: 'Preview generated', data: preview_data)
          else
            render_error(message: 'Failed to fetch URL', status: :bad_request)
          end
        rescue StandardError => e
          render_error(message: 'Failed to generate preview', errors: [e.message])
        end
      end
    end
  end
end
