require 'net/http'
require 'uri'
require 'json'
require 'fileutils'

module Everhour2toggl
  class Everhour
    def initialize(from:, to:, fields:, apikey:)
      @from = from
      @to =  to
      @fields = fields
      @apikey = apikey
    end

    def export
      output_path = "everhour_entries"
      file_generator = Everhour2toggl::FileGenerator.new(output: output_path, filename: "#{@from}-#{@to}-#{@fields}.json")
      file_generator.generate(exported_time_str)
    end

    private

    def exported_time_str
      uri = URI.parse("https://api.everhour.com/team/time/export")
      params = {from: @from, to: @to, "fields": @fields}
      uri.query = URI.encode_www_form(params)

      request = Net::HTTP::Get.new(uri)
      request.content_type = "application/json"
      request["X-Api-Key"] = @apikey

      req_options = {
          use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      # response.code
      JSON.pretty_generate(JSON.parse(response.body))
    end
  end
end
