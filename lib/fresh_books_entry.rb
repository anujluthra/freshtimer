class FreshBooksEntry

  def initialize(options = {})
    @duration = options[:duration]
    @notes = options[:comments]
    @date  = options[:start_time].to_date
  end


  def upload
    FRESH_BOOKS.time_entry.create(
      :time_entry => freshbooks_hash
    )
  end

  def freshbooks_hash
    { :project_id => default_project_id,
      :task_id    => default_task_id,
      :hours      => @duration,
      :notes      => @notes,
      :date       => @date.to_s
    }
  end

  def self.sync_to_remote(entries)
    entries.each do |entry|
      new(entry.freshtimer_attributes).upload
      entry.synced!
    end
  end

  private

  def default_project_id
    CONFIG["freshbooks"]["default_project_id"].to_i
  end

  def default_task_id
    CONFIG["freshbooks"]["default_task_id"].to_i
  end


  
end