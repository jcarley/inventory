class Token
  include Entity

  belongs_to :user, index: true

  field :token, :type => String
  field :user_id, :type => String
  field :expiration, :type => String

  def self.create_access_token_for(user, unique_data)
    secret_key = user.secret_key
    expiration = create_expiration
    unsigned_token = "#{secret_key}:#{unique_data}:#{expiration}"

    digest = OpenSSL::Digest::SHA256.new
    token = OpenSSL::HMAC::hexdigest(digest, secret_key, unsigned_token)

    token_record = new(token: token, user_id: user.id, expiration: expiration)

    return token_record
  end

  def self.create_expiration
    (DateTime.now + 1.day).rfc3339(9)
  end

  def to_json(options = {})
    {:token => self.token, :expiration => self.expiration}.to_json(options)
  end

end
