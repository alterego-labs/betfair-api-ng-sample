require './lib/api/base_provider'
require './lib/api/bf/config'

Dir['./lib/api/bf/parsers/soccer/**/*.rb'].each {|f| require f}

module Api
  module BF
    class Provider < Api::BaseProvider

      def fetch(data: "", parameters: {}, sport: "")
        puts 'fetch called!'
        parser = build_parser(data, sport)
        parser.parse response: ""
        []
      end

    end
  end
end