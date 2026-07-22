module Api
  module V1
    class MusicSearchController < ApplicationController
      before_action :authenticate_request!

      def search
        query = (params[:query] || params[:q]).to_s.strip
        return render_error(message: 'Query parameter is required', status: :bad_request) if query.length < 2

        begin
          results = fetch_itunes_tracks(query)
          render_success(message: 'Music search completed', data: { tracks: results })
        rescue StandardError => e
          Rails.logger.error "Music search error: #{e.class} #{e.message}"
          render_error(message: 'Failed to search music', errors: [e.message])
        end
      end

      private

      def fetch_itunes_tracks(query)
        encoded = URI.encode_www_form_component(query)
        url = "https://itunes.apple.com/search?term=#{encoded}&media=music&entity=song&limit=25&explicit=No"

        uri = URI(url)
        response_body = nil

        thread = Thread.new do
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl      = true
          http.open_timeout = 8
          http.read_timeout = 12

          req = Net::HTTP::Get.new(uri.request_uri)
          req['User-Agent'] = 'Mozilla/5.0 (compatible; SangamApp/1.0)'
          req['Accept']     = 'application/json'

          res = http.request(req)
          response_body = res.body if res.is_a?(Net::HTTPSuccess)
        end

        thread.join(14)

        return [] unless response_body

        data = JSON.parse(response_body)
        (data['results'] || []).map do |t|
          {
            id:          t['trackId'],
            title:       t['trackName'],
            artist:      t['artistName'],
            album:       t['collectionName'],
            cover:       t['artworkUrl100'] || t['artworkUrl60'],
            preview_url: t['previewUrl'],
            preview:     t['previewUrl'],
            duration:    t['trackTimeMillis'] ? (t['trackTimeMillis'] / 1000).to_i : nil,
            genre:       t['primaryGenreName']
          }
        end
      end
    end
  end
end
