require 'net/http'
require 'uri'

app_key = "QvBPLfOmIWJXuxvd"
session_key = "GDpf6ql+hnDC00qideBfXe7eYGpyqH8TZINUDjezLuI="

uri = URI.parse("https://api-ng.betstores.com/betting/betfair/services/api.betfair.com/exchange/betting/json-rpc/v1")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
request.body = "{\"jsonrpc\": \"2.0\", \"method\": \"SportsAPING/v1.0/listCompetitions\", \"params\": {\"filter\": { }}}"
request["Content-Type"] = "application/json"
request["Accept"] = "application/json"
request["X-Application"] = app_key
request["X-Authentication"] = session_key

response = http.request request

puts response.inspect
puts response.body