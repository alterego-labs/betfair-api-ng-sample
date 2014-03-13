require './lib/api/soccer/requester'
require './lib/api/bf/provider'

class Api::Soccer::CompetitionRequester < Api::Soccer::Requester

  def initialize(provider: '')
    @data = :competition
    super provider
  end

  def load(parameters: {})
    current_provider.fetch data: data, parameters: parameters, sport: sport
  end

end