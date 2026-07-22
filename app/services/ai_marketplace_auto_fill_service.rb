require "net/http"
require "uri"
require "json"

class AiMarketplaceAutoFillService
  def initialize(params)
    if params.is_a?(Hash)
      @image_data_url = params[:image_data_url]
      @description = params[:description]
    else
      @image_data_url = params
    end
  end

  def generate
    api_key = ENV["GROQ_API_KEY"]

    if @image_data_url.blank? && @description.blank?
      return { success: false, error: "No image or description provided" }
    end

    messages = []
    if @image_data_url.present?
      messages << {
        role: "user",
        content: [
          { type: "text", text: "You are an expert marketplace seller. Analyze this image of an item being sold. Generate a JSON object with exactly four keys: 'title' (a short, catchy title for the listing), 'description' (a detailed and appealing description of the item), 'category' (you MUST choose exactly one from this list: electronics, furniture, clothing, vehicles, property, sports, books, toys, garden, other), and 'price' (estimated numeric price value). Do not output any markdown formatting like ```json, just output the raw JSON object." },
          { type: "image_url", image_url: { url: @image_data_url } }
        ]
      }
      model = "llama-3.2-11b-vision-preview"
    else
      messages << {
        role: "user",
        content: "You are an expert marketplace seller. Based on this text description: '#{@description}', optimize and structure the marketplace listing. Return ONLY a raw JSON object with keys: 'title' (catchy title), 'description' (enhanced description), 'category' (choose exactly one from: electronics, furniture, clothing, vehicles, property, sports, books, toys, garden, other), 'condition' (choose from: brand_new, like_new, good, fair), and 'price' (estimated reasonable price integer or number). Do not output markdown like ```json."
      }
      model = "llama-3.1-8b-instant"
    end

    uri = URI("https://api.groq.com/openai/v1/chat/completions")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{api_key}"
    request["Content-Type"] = "application/json"

    request.body = JSON.dump({
      "model" => model,
      "messages" => messages,
      "temperature" => 0.5,
      "max_completion_tokens" => 500
    })

    req_options = {
      use_ssl: uri.scheme == "https"
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      result = JSON.parse(response.body)
      content = result.dig("choices", 0, "message", "content") || ""
      
      # Clean up potential markdown formatting
      cleaned_content = content.gsub(/```json/i, "").gsub(/```/, "").strip
      
      begin
        parsed_json = JSON.parse(cleaned_content)
        { success: true, data: parsed_json }
      rescue JSON::ParserError => e
        Rails.logger.error("JSON Parsing Error in AiMarketplaceAutoFillService: #{e.message} - Raw content: #{content}")
        { success: false, error: "Failed to parse AI response as JSON" }
      end
    else
      Rails.logger.error("Groq API Error: #{response.body}")
      { success: false, error: response.body }
    end
  rescue StandardError => e
    Rails.logger.error("AiMarketplaceAutoFillService Error: #{e.message}")
    { success: false, error: e.message }
  end
end
