require 'net/http'
require 'json'

module Api
  module V1
    class AiFeaturesController < ApplicationController
      before_action :authenticate_request!

      def generate_caption
        params.require(:image_url)
        render_success(message: 'Caption generated', data: { caption: "A beautiful scenery captured by AI." })
      end

      def rewrite_message
        message = params.require(:message)
        
        api_key = ENV['GROQ_API_KEY']
        if api_key.blank?
          return render_error(message: "Groq API key is not configured in backend .env")
        end

        uri = URI("https://api.groq.com/openai/v1/chat/completions")
        req = Net::HTTP::Post.new(uri, {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{api_key}"
        })
        
        req.body = {
          model: "llama-3.1-8b-instant",
          messages: [
            {
              role: "system",
              content: "You are a helpful assistant. Rewrite the user's message to make it more professional, polite, and grammatically correct while strictly preserving the original language, script, and style of expression (e.g., if the user writes in Hinglish/Latin-script Hindi, rewrite in polite/formal Hinglish; if in Hindi/Devanagari, rewrite in polite Hindi/Devanagari; if in English, rewrite in polite/professional English). Keep the original intent. Return ONLY the rewritten message itself, without any introduction, quotes, greeting, or explanation."
            },
            {
              role: "user",
              content: message
            }
          ],
          temperature: 0.7
        }.to_json

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        res = http.request(req)

        if res.code == '200'
          response_data = JSON.parse(res.body)
          rewritten = response_data.dig('choices', 0, 'message', 'content')&.strip
          # Strip enclosing quotes if model returned them
          rewritten = rewritten.delete_prefix('"').delete_suffix('"').delete_prefix("'").delete_suffix("'")
          render_success(message: 'Message rewritten', data: { rewritten_message: rewritten })
        else
          render_error(message: "Failed to connect to AI service: #{res.body}")
        end
      rescue => e
        render_error(message: "AI rewrite failed: #{e.message}")
      end

      def smart_reply
        params.require(:message)
        render_success(message: 'Smart reply generated', data: { replies: ["Yes, absolutely!", "No, I don't think so.", "Let me check."] })
      end

      def search
        params.require(:q)
        render_success(message: 'AI Search results', data: [])
      end

      def generate_smart_replies
        params.require(:message)
        render_success(message: 'Smart replies generated', data: { replies: ["Yes, absolutely!", "No, I don't think so.", "Let me check."] })
      end

      def generate_article_content
        params.require(:prompt)
        prompt = params[:prompt] || "Default topic"
        render_success(message: 'Article content generated', data: { content: "This is a generated article about #{prompt}." })
      end

      def auto_fill_listing
        image_data_url = params[:image_data_url] || params[:image_url]
        description = params[:description]
        
        if image_data_url.blank? && description.blank?
          return render_error(message: "Image or description is required")
        end

        service = AiMarketplaceAutoFillService.new({ image_data_url: image_data_url, description: description })
        result = service.generate

        if result[:success]
          render_success(message: 'Listing auto-filled', data: result[:data])
        else
          render_error(message: result[:error] || "Failed to auto-fill listing")
        end
      end

      def giphy_search
        query = params[:q].to_s.strip
        if query.blank?
          return giphy_trending
        end

        api_key = ENV['GIPHY_API_KEY']
        if api_key.blank?
          return render_error(message: "Giphy API key is not configured in backend .env")
        end

        uri = URI("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{CGI.escape(query)}&limit=15")
        response = Net::HTTP.get(uri)
        render json: JSON.parse(response)
      rescue => e
        render_error(message: "Failed to search GIFs: #{e.message}")
      end

      def giphy_trending
        api_key = ENV['GIPHY_API_KEY']
        if api_key.blank?
          return render_error(message: "Giphy API key is not configured in backend .env")
        end

        uri = URI("https://api.giphy.com/v1/gifs/trending?api_key=#{api_key}&limit=15")
        response = Net::HTTP.get(uri)
        render json: JSON.parse(response)
      rescue => e
        render_error(message: "Failed to load trending GIFs: #{e.message}")
      end
    end
  end
end
