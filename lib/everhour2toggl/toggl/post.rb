require 'net/http'
require 'uri'
require 'json'

module Everhour2toggl
  class Toggl::Post
    def initialize(api_token:, input:)
      @api_token = api_token
      @input = input
    end

    def post
      uri = URI.parse("https://www.toggl.com/api/v8/time_entries")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(@api_token, "api_token")
      request.content_type = "application/json"

      req_options = {
          use_ssl: uri.scheme == "https",
      }

      entries = JSON.parse(File.read(@input))
      responses = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        entries.each do |entry|
          request.body = JSON.dump(entry)
          http.request(request)
        end
      end
      # puts responses
    end
  end
end
