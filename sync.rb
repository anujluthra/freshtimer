load 'init.rb'

SlimTimerEntry.sync_with_remote
FreshBooksEntry.sync_to_remote(SlimTimerEntry.unsynced)
puts "All done ... bye"




