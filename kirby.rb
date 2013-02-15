require 'rest-open-uri'

require File.join(File.dirname(__FILE__), '/config/active_record')
require File.join(File.dirname(__FILE__), '/models/link')

class Kirby
  def suck_urls(tweet)
    return if tweet.urls.empty?
    tweet.urls.each do |url|
      begin
        Link.create(
          url:      follow_link(url.expanded_url),
          tweet_id: tweet.id,
          posted_at: tweet.created_at
        )
      rescue
      end
    end
  end

  private

  def follow_link(url)
    uri = open(url, method: :head)
    uri.base_uri.to_s
  end
end
