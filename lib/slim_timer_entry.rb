class SlimTimerEntry
  include DataMapper::Resource

  property :id,                   Serial
  property :duration_in_seconds,	Integer
  property :sync_id,              Integer, :required => true, :unique => true
  property :comments,             String
  property :start_time,           DateTime, :required => true
  property :end_time,             DateTime, :required => true
  property :task_name,            String,   :required => true
  property :synced,               Boolean,  :default  => false
  property :tags,                 String


  def self.unsynced
    all(:synced => false)
  end

  

  def self.sync_with_remote
    synced = 0
    SLIM_TIMER.list_timeentries.each{|record|
      begin
        create(
          :sync_id =>             record['id'],
          :duration_in_seconds => record['duration_in_seconds'].to_i,
          :comments =>            record['comments'],
          :start_time =>          record['start_time'],
          :end_time =>            record['end_time'],
          :task_name =>           record['task']['name'],
          :tags =>                record['tags']
        )
        synced += 1
      rescue DataObjects::IntegrityError => e
        print "*"
      end
    }
    puts "Successfully synced #{synced} new time entries"
  end

end
