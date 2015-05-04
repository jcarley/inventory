class User
  include Entity

  field :email, type: String
  field :encrypted_password, type: String
  field :confirmation_token, type: String
  field :remember_token, type: String

  def self.find_by_email(email)
    find_by(:email => email)
  end

end
