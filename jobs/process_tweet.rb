require_relative '../config/twitter'
require_relative '../config/sidekiq'
require_relative '../kirby'

class ProcessTweet
  include Sidekiq::Worker

  def perform(tweet_id)
    begin
      status = Twitter.status(tweet_id)
      Kirby.new.suck_urls(status)
    rescue Twitter::Error::NotFound => error
      puts "TWITTER ERROR: Tweet with id #{tweet_id} was not found. \n#{error}"
    end
  end
end
