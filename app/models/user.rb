class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Clearance::User

  field :email, type: String
  field :encrypted_password, type: String
  field :confirmation_token, type: String
  field :remember_token, type: String

  def self.find_by_email(email)
    find_by(:email => email)
  end

end
