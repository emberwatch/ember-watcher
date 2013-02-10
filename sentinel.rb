require 'rubygems'
require 'bundler/setup'
require 'msgpack'

require File.dirname(__FILE__) + '/jobs/process_tweet'
require File.dirname(__FILE__) + '/config/tweetstream'
require File.dirname(__FILE__) + '/config/sidekiq'

TweetStream::Daemon.new.track('#emberjs', "ember.js", "ember-data") do |status|
  ProcessTweet.perform_async(MessagePack.pack(status.attrs))
end
