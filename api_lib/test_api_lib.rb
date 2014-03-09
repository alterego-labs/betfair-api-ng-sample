require './lib/api/soccer/competition_requester'

requester = Api::Soccer::CompetitionRequester.new :bf
res = requester.load

puts res