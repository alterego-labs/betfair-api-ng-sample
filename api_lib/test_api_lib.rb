require './lib/api/soccer/competition_requester'
require './lib/api/bf/config'
require 'yaml'

root = File.dirname(File.expand_path(__FILE__))

puts "Root folder: #{root}"

load_config = YAML.load_file("#{root}/config.yml")

#CONFIGURATING BETFAIR
Api::BF::Config.application_key = load_config['application_key']
Api::BF::Config.ssl_key_filepath = "#{root}/public/client-2048.key"
Api::BF::Config.ssl_crt_filepath = "#{root}/public/client-2048.crt"
Api::BF::Config.login_url = load_config['login_url']
Api::BF::Config.api_url = load_config['api_url']

#CREATING REQUEST FOR COMPETITIONS LIST
requester = Api::Soccer::CompetitionRequester.new :bf
res = requester.load

#PUTS RESULTS
puts res