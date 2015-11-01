class TokenRepository

  def initialize(db = Services::CacheStore.new)
    @db = db
  end

  def find(user_id)
    db.fetch(user_id)
  end

  def save(token)
    db.set(token.user_id, token.to_json)
  end

  def delete_by(user_id)
    token = self.find(user_id)
    self.delete(token)
  end

  def delete(token)
    db.delete(token.user_id)
  end

  private
  attr_reader :db

end

