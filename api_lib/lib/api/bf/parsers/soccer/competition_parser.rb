require './lib/api/base_parser'

module Api
  module BF
    module Parsers
      module Soccer
        class CompetitionParser < Api::BaseParser

          def parse(response: "")
            puts 'parse called!'
          end

        end
      end
    end
  end
end