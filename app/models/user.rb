class User
  include Entity

  has_many :tokens

  # ===========  New Fields ===========
  field :secret_key, type: String
  field :enabled, type: Boolean
  # ===================================

  field :email, type: String
  field :encrypted_password, type: String
  field :confirmation_token, type: String
  field :remember_token, type: String

  def self.find_by_email(email)
    find_by(:email => email)
  end

end
