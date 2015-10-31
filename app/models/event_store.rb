class EventStore

  def self.save(event)
    event.save!
  end

end

