#!/usr/bin/env ruby

require "rubygems"
require "twitter"
require_relative "secrets"

client = Twitter::REST::Client.new do |config|
  config.consumer_key = TWITTER_CONSUMER_KEY
  config.consumer_secret = TWITTER_CONSUMER_SECRET
  config.access_token = TWITTER_ACCESS_TOKEN
  config.access_token_secret = TWITTER_ACCESS_SECRET
end

timeline = client.home_timeline.reverse
mentions = client.mentions.reverse

puts "Welcome to twitter_cli."

loop do
  puts "What would you like to do?"
  puts "t = View your timeline"
  puts "s = Send a tweet"
  puts "m = View your mentions"
  puts "h = #hashtag search"
  puts "q = Quit"

  choice = gets.chomp.downcase

  case choice
  when "t"
    timeline.each do |tweet|
      puts tweet.text + " FROM @#{tweet.user.screen_name}"
      puts "\n"
    end
  when "s"
    puts "Please enter your tweet:"
    status = STDIN.readline.chomp
    client.update("#{status}")
  when "m"
    mentions.each do |tweet|
      puts tweet.text + " FROM @#{tweet.user.screen_name}"
      puts "\n"
    end
  when "h"
    puts "Enter a hashtag to search for (remember to include the # symbol):"
    hashtag = gets.chomp.downcase
    client.search(hashtag).take(10).each do |tweet|
      puts tweet.text + " FROM @#{tweet.user.screen_name}"
      puts "\n"
    end
  when "q"
    puts "Goodbye!"
    exit
  else
    puts "Sorry, that's not a valid option. Please try again."
  end
end
