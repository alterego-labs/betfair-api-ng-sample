require './lib/api/soccer/requester'
require './lib/api/bf/provider'

class Api::Soccer::CompetitionRequester < Api::Soccer::Requester

  def initialize(provider)
    @method = "listCompetitions"
    super provider
  end

  def load(parameters: {})
    current_provider.fetch function: method, parameters: parameters, sport: sport
  end

end