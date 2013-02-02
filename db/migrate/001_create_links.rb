class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :tweet_id, :url
      t.datetime :posted_at
      t.timestamps
    end

    add_index :links, :posted_at, order: { posted_at: :asc, created_at: :asc }
    add_index :links, :tweet_id
    add_index :links, :url
  end

  def self.down
    drop_table :links
  end
end
