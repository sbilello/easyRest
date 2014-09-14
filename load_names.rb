#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'net/http'

client = Net::HTTP.new("localhost", 8080)

File.open("names.txt").each_line do |name|
	name.chomp!
	client.post("/test/rest/developer", JSON.dump({:name => name}), {"Content-Type"=>"application/json"})
end

puts "All done!"

