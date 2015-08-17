#!/usr/bin/env ruby

require "rubygems"
require "twitter_oauth"
require_relative "secrets"

client = TwitterOAuth::Client.new(
  consumer_key: TWITTER_CONSUMER_KEY,
  consumer_secret: TWITTER_CONSUMER_SECRET,
  token: TWITTER_ACCESS_TOKEN,
  secret: TWITTER_ACCESS_SECRET)

timeline = client.home_timeline.reverse
mentions = client.mentions.reverse

loop do
  puts "Welcome to twitter_cli. What would you like to do?"
  puts "t = View your timeline"
  puts "s = Send a tweet"
  puts "m = View your mentions"
  puts "h = #hashtag search"

  choice = gets.chomp.downcase

  case choice
  when "t"
    timeline.each do |tweet|
      puts tweet["text"] + " @FROM #{tweet["user"]["name"]}"
      puts "\n"
    end
  when "s"
    puts "Please enter your status:"
    status = STDIN.readline.chomp
    client.update("#{status}")
  when "m"
    mentions.each do |tweet|
      puts tweet["text"] + " @FROM #{tweet["user"]["name"]}"
      puts "\n"
    end
  when "h"
    puts "Enter a hashtag to search for (remember to include the # symbol)"
    hashtag = gets.chomp.downcase
    client.search(hashtag).take(10).each do |tweet|
      puts tweet["text"]
    end
  else
    puts "Sorry, that's not a valid option. Please try again."
  end
end
