require './lib/api/base_provider'
require './lib/api/bf/config'
require './lib/api/bf/session_manager'
require './lib/api/bf/constants'

Dir['./lib/api/bf/parsers/soccer/**/*.rb'].each {|f| require f}

module Api
  module BF
    class Provider < Api::BaseProvider
      include Api::BF::Constants

      attr_reader :session_manager, :current_method

      def initialize
        @session_manager = Api::BF::SessionManager.new
      end

      def fetch(data: "", parameters: {}, sport: "")
        puts 'fetch called!'
        return [] unless session_manager.request_ssoid
        @current_method = data
        do_request data, parameters, sport
      end

    private

      def do_request(data, parameters, sport)
        process_response build_http.request(build_request).body, build_parser(data, sport)
      end

      def process_response(response, parser)
        parser.parse response: response
      end

      def api_uri
        @_api_uri ||= URI.parse Api::BF::Config.api_url
      end

      def build_http
        Net::HTTP.new(uri.host, uri.port).tap do |http|
          http.use_ssl = true
        end
      end

      def build_request
        Net::HTTP::Post.new(uri.request_uri).tap do |request|
          setup_request_body request
          setup_request_headers request
          setup_request_authentication request
        end
      end

      def setup_request_body(request)
        request.body = "{\"jsonrpc\": \"2.0\", \"method\": \"SportsAPING/v1.0/#{build_function(current_method)}\", \"params\": {\"filter\": { }}}"
      end

      def setup_request_headers(request)
        request["Content-Type"] = "application/json"
        request["Accept"] = "application/json"
      end

      def setup_request_authentication(request)
        request["X-Application"] = Api::BF::Config.application_key
        request["X-Authentication"] = session_manager.ssoid
      end

    end
  end
end