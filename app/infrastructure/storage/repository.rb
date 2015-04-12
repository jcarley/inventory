module Storage
  module Repository

    def initialize(db)
      @db = db
    end

    def find(id)
      db.find(id)
    end

    def save(record)
      record.save?
    end

    def delete_by(id)
      record = db.find_by(:id => id)
      self.delete(record)
    end

    def delete(record)
      record.destroy
    end

    def load_all(&block)
      db.find_each.lazy.each(&bock)
    end

    def list(offset = 0, limit = 5)
      db.all.skip(offset).limit(limit).to_a
    end

    private
    attr_reader :db

  end
end

