require 'rubygems'
require 'bundler/setup'
require 'sidekiq'

require File.dirname(__FILE__) + '/jobs/process_tweet'
require File.dirname(__FILE__) + '/config/tweetstream'

TweetStream::Daemon.new.track('#emberjs', "ember.js", "ember-data") do |status|
  ProcessTweet.perform_async(Marshal.dump(status.attrs))
end
