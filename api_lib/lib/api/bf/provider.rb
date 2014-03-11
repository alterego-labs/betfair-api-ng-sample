require './lib/api/base_provider'
require './lib/api/bf/config'
require './lib/api/bf/session_manager'
require './lib/api/bf/constants'
require './lib/api/bf/http_requester'

Dir['./lib/api/bf/parsers/soccer/**/*.rb'].each {|f| require f}

module Api
  module BF
    class Provider < Api::BaseProvider
      include Api::BF::Constants

      attr_reader :session_manager, :current_method

      def initialize
        @session_manager = Api::BF::SessionManager.new
        setup_http_requester
      end

      def fetch(data: "", parameters: {}, sport: "")
        puts 'fetch called!'
        return [] unless session_manager.request_ssoid
        @current_method = data
        do_request data, parameters, sport
      end

    private

      def do_request(data, parameters, sport)
        process_response @http_requester.do_request, build_parser(data, sport)
      end

      def process_response(response, parser)
        parser.parse response: response
      end

      def setup_http_requester
        @http_requester = Api::BF::HttpRequester.new(Api::BF::Config.api_url).tap do |req|
          req.set_request_headers { "Content-Type" => "application/x-www-form-urlencoded", "Accept" => "application/json" }
          req.set_auth_headers Api::BF::Config.application_key, session_manager.ssoid
          req.set_api_req_body build_function(current_method)
        end
      end

    end
  end
end