require 'active_record'
require 'logger'
require 'uri'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Migration.verbose = true

if ENV['RACK_ENV'] == 'development'
  dbconfig = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection dbconfig[ENV['RACK_ENV']]
else
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :port     => db.port,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end
