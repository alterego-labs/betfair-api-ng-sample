require "net/https"
require "uri"
require 'json'

crt = File.read("client-2048.crt")
key = File.read("client-2048.key")

uri = URI.parse("https://identitysso.betfair.com/api/certlogin")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.cert = OpenSSL::X509::Certificate.new(crt)
http.key = OpenSSL::PKey::RSA.new(key)
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
request = Net::HTTP::Post.new(uri.request_uri)
request["Content-Type"] = "application/x-www-form-urlencoded"
request["X-Application"] = "QvBPLfOmIWJXuxvd"
request.set_form_data({"username" => "sergeg1990", "password" => "SeRgIo2014"})
response = http.request request

puts JSON.parse(response.body)['loginStatus']

