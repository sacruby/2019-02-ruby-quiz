require 'net/http'

server, *numbers = ARGV
uri = URI("#{server}/#{numbers.join}")

Net::HTTP.start(uri.host, uri.port) do |http|
  exit(http.request(Net::HTTP::Get.new(uri)).code == '200' ? 0 : 1)
end
