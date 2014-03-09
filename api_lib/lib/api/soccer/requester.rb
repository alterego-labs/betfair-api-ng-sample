require './lib/api/base_requester'

module Api
  module Soccer
    class Requester < Api::BaseRequester

      def initialize(provider)
        @sport = :soccer
        super provider
      end

    end
  end
end