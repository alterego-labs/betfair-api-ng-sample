require "net/https"
require "uri"
require 'json'
require './lib/api/bf/config'
require './lib/api/bf/constants'

module Api
  module BF
    class SessionManager
      include Api::BF::Constants

      attr_reader :ssoid, :loginSuccess

      def initialize
        @loginSuccess = false
      end

      def ssoid
        @ssoid ||= fetch_ssoid
      end

    private

      def fetch_ssoid
        process_response get_login_response
      end

      def process_response(response)
        @loginSuccess = response['loginStatus'] == SUCCESS_LOGIN
        response['sessionToken']
      end

      def get_login_response
        JSON.parse build_http.request(build_request).body
      end

      def login_uri
        @_login_uri ||= URI.parse Api::BF::Config.login_url
      end

      def build_http
        Net::HTTP.new(login_uri.host, login_uri.port).tap do |http|
          setup_http_ssl http
        end
      end

      def setup_http_ssl(http)
        http.use_ssl = true
        http.cert = OpenSSL::X509::Certificate.new read_ssl_file(Api::BF::Config.ssl_crt_filepath)
        http.key = OpenSSL::PKey::RSA.new read_ssl_file(Api::BF::Config.ssl_key_filepath)
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end

      def build_request
        Net::HTTP::Post.new(login_uri.request_uri).tap do |request|
          request["Content-Type"] = "application/x-www-form-urlencoded"
          request["X-Application"] = Api::BF::Config.application_key
          request.set_form_data {"username" => Api::BF::Config.username, "password" => Api::BF::Config.password}
        end
      end

      def read_ssl_file(path)
        File.read path
      end

    end
  end
end