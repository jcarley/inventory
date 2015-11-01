module Storage
  module Repository

    def initialize(db)
      @db = db
    end

    def find(id)
      db.find(id)
    end

    def load_all(&block)
      db.find_each.lazy.each(&bock)
    end

    def list(offset = 0, limit = 5)
      db.all.skip(offset).limit(limit).to_a
    end

    def create(attrs)
      record = db.new
      apply_change(record, "created", attrs)
      record
    end

    def delete_by(id)
      record = db.find(id)
      self.delete(record)
      self.save(record)
      record
    end

    def delete(record)
      apply_change(record, "destroyed", :id => record.id)
      record
    end

    def modify(record, attrs)
      apply_change(record, "modified", attrs)
      record
    end

    def save(record)
      record_uncommited_events(record)
      result = record.deleted? ? _destroy_record(record) : _create_or_update_record(record)
      mark_events_as_committed(record)
      result
    end

    protected

    attr_reader :db

    def apply_change(record, event_name, attrs)
      event = "#{record.class.name.downcase}_#{event_name}_event".to_sym
      record.apply_event(event, attrs)
    end

    private

    def record_uncommited_events(record)
      record.applied_events.each do |event|
        EventStore.save(event)
      end
    end

    def mark_events_as_committed(record)
      record.applied_events.clear
    end

    def _destroy_record(record)
      record.destroy
    end

    def _create_or_update_record(record)
      if record.new_record?
        record.save?
      elsif record.changed? && ! record.new_record?
        # There is an unnecessary assignment that happens here, but calling
        # update is essential to make sure the changes to the database happen
        # within a transaction.  ActiveRecord does not support an empty
        # parameter update
        record.update(record.attributes)
      else
        true
      end
    end

  end
end

