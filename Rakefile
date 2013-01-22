require "rubygems"
require "bundler/setup"
require "active_record"

namespace :db do
  task :environment do
    load 'config/active_record.rb'
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
