require_relative '../config/sidekiq'
require_relative '../kirby'

class ProcessTweet
  include Sidekiq::Worker

  def perform(marshalled_tweet)
    Kirby.new.suck_urls(marshalled_tweet)
  end
end
