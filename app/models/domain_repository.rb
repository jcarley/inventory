class DomainRepository

  def self.save(entity)
    entity.save!
  end

end

