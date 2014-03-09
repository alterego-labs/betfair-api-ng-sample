require './lib/api/base_provider'

module Api
  module BF
    class Provider < Api::BaseProvider

      def fetch(data: "", parameters: {}, sport: "")
        puts 'fetch called!'
        []
      end

    end
  end
end