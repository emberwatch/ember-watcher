require 'active_record'
require 'logger'

dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Migration.verbose = true
ActiveRecord::Base.establish_connection dbconfig[ENV['RACK_ENV']]
