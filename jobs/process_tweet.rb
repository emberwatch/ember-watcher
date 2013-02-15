require_relative '../config/twitter'
require_relative '../config/sidekiq'
require_relative '../kirby'

class ProcessTweet
  include Sidekiq::Worker

  def perform(tweet_id)
    status = Twitter.status(tweet_id)
    Kirby.new.suck_urls(status)
  end
end
