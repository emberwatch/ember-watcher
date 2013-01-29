require 'rubygems'
require 'bundler/setup'
require File.dirname(__FILE__) + '/models/tweet'

require File.dirname(__FILE__) + '/config/tweetstream'

TweetStream::Daemon.new.track('#emberjs', "ember.js") do |status|
  status.urls.each do |url|
    Tweet.create(tweet_id: status.id, url: url.expanded_url)
  end
end
