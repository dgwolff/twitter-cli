#!/usr/bin/env ruby

require "rubygems"
require "twitter_oauth"
require_relative "secrets"

client = TwitterOAuth::Client.new(
  consumer_key: TWITTER_CONSUMER_KEY,
  consumer_secret: TWITTER_CONSUMER_SECRET,
  token: TWITTER_ACCESS_TOKEN,
  secret: TWITTER_ACCESS_SECRET)

case ARGV[0]
when "-l"
  timeline = client.home_timeline()
  timeline = timeline.reverse
  timeline.each{ |tweet|
    puts tweet["text"] + " @FROM #{tweet["user"]["name"]}"
    puts "\n"
  }
when "-u"
  if ARGV[1].nil?
    puts "Please enter your status:"
    status = STDIN.readline.chomp
    client.update("#{status}")
  else
    client.update("#{ARGV[1]}")
  end
when "-m"
  mentions = client.mentions()
  mentions = mentions.reverse
  mentions.each{ |tweet|
    puts tweet["text"] + " @FROM #{tweet["user"]["name"]}"
    puts "\n"
  }
end
