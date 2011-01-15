require 'rubygems'
require 'activesupport'
require 'dm-core'
require 'dm-migrations'
require 'yaml'
require 'slimtimer4r'
require 'ruby-freshbooks'
require 'ruby-duration'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, 'sqlite://' + Dir.pwd + '/' + 'freshtimer.db')

load 'lib/slim_timer_entry.rb'
load 'lib/fresh_books_entry.rb'
load 'lib/time_conversion.rb'

include TimeConversion

# create the db schema with properties in models
DataMapper.auto_upgrade!
DataMapper.finalize

CONFIG = YAML.load_file('config.yaml')
SLIM_TIMER = SlimTimer.new(*CONFIG['slimtimer'].values)
FRESH_BOOKS = FreshBooks::Client.new(CONFIG['freshbooks']['account'],CONFIG['freshbooks']['api_token'] )





