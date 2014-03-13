require './lib/api/soccer/competition_requester'
require './lib/api/bf/config'
require './lib/api/bf/session_manager'
require 'yaml'
require 'pry-nav'

root = File.dirname(File.expand_path(__FILE__))

puts "Root folder: #{root}"

#LOADING CONFIGURATION FILE AS YAML
load_config = YAML.load_file("#{root}/config.yml")

#CONFIGURATING BETFAIR
Api::BF::Config.application_key = load_config['betfair']['application_key']
Api::BF::Config.ssl_key_filepath = "#{root}/public/client-2048.key"
Api::BF::Config.ssl_crt_filepath = "#{root}/public/client-2048.crt"
Api::BF::Config.login_url = load_config['betfair']['login_url']
Api::BF::Config.api_url = load_config['betfair']['api_url']
Api::BF::Config.username = load_config['betfair']['username']
Api::BF::Config.password = load_config['betfair']['password']

#CREATING REQUEST FOR COMPETITIONS LIST
requester = Api::Soccer::CompetitionRequester.new provider: :bf
res = requester.load
binding.pry

#PUTS RESULTS
puts res

# session_manager = Api::BF::SessionManager.new
# puts session_manager.ssoid
