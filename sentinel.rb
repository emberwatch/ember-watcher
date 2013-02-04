require 'rubygems'
require 'bundler/setup'

require File.dirname(__FILE__) + '/jobs/process_tweet'
require File.dirname(__FILE__) + '/config/tweetstream'
require File.dirname(__FILE__) + '/config/sidekiq'

TweetStream::Daemon.new.track('#emberjs', "ember.js", "ember-data") do |status|
  ProcessTweet.perform_async(Marshal.dump(status.attrs))
end
