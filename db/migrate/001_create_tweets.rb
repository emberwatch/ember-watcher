class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :tweet_id, :url
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :tweets
  end
end
