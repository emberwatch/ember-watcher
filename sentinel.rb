require 'rubygems'
require 'bundler/setup'
require 'tweetstream'
require File.dirname(__FILE__) + '/models/tweet'

# Patch TweetStream Daemon for Heroku
# See https://github.com/heroku-examples/tweetstream-example
class TweetStream::Daemon
  def start(path, query_parameters = {}, &block)
    startmethod = super.start
    Daemons.run_proc(@app_name || 'tweetstream', :multiple => true, :no_pidfiles => true) do
      startmethod(path, query_parameters, &block)
    end
  end
end

TweetStream.configure do |config|
  config.consumer_key       = ENV['CONSUMER_KEY']
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.oauth_token        = ENV['OAUTH_TOKEN']
  config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  config.auth_method        = :oauth
end

TweetStream::Daemon.new.track('#emberjs', "ember.js") do |status|
  status.urls.each do |url|
    Tweet.create(tweet_id: status.id, url: url.expanded_url)
  end
end
