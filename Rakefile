require "rubygems"
require "bundler/setup"
require "active_record"
require "csv"
require "msgpack"

namespace :db do
  task :environment do
    load 'config/active_record.rb'
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end

namespace :data do
  task :environment do
    load 'config/twitter.rb'
    load 'jobs/process_tweet.rb'
  end

  task(:import_one => :environment) do
    table = CSV.read("data.csv", headers: true)
    tweet_ids = table.map {|row| row["tweet_id"] }
    tweet_ids = tweet_ids[0..138]
    puts "Fetching tweets"
    tweet_ids.each do |id|
      putc '.'
      status = Twitter.status(id, include_entities: true)
      ProcessTweet.perform_async(MessagePack.pack(status.attrs))
    end
    puts ""
    puts "Finished"
  end

  task(:import_two => :environment) do
    table = CSV.read("data.csv", headers: true)
    tweet_ids = table.map {|row| row["tweet_id"] }
    tweet_ids = tweet_ids[139..-1]
    puts "Fetching tweets"
    tweet_ids.each do |id|
      putc '.'
      status = Twitter.status(id, include_entities: true)
      ProcessTweet.perform_async(MessagePack.pack(status.attrs))
    end
    puts ""
    puts "Finished"
  end
end
