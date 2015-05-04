FactoryGirl.define do
  factory :user do
    email "jdoe@example.com"
    encrypted_password "password"
    confirmation_token "ABC123"
    remember_token "XYZ890"
  end

end
