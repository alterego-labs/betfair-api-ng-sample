require './lib/api/soccer/competition_requester'

root = File.dirname(File.expand_path(__FILE__))

puts "Root folder: #{root}"

requester = Api::Soccer::CompetitionRequester.new :bf
res = requester.load

puts res