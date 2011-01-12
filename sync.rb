require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'yaml'
require 'slimtimer4r'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, 'sqlite://' + Dir.pwd + '/' + 'freshtimer.db')

load 'lib/slim_timer_entry.rb'

# create the db schema with properties in models
DataMapper.auto_upgrade!

DataMapper.finalize

CONFIG = YAML.load_file('config.yaml')
SLIM_TIMER = SlimTimer.new(*CONFIG['slimtimer'].values)

SlimTimerEntry.sync_with_remote





