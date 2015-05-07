FactoryGirl.define do
  factory :user do
    email "jdoe@example.com"
    secret_key "1af91883-dc28-401d-b289-51054b5f18d8"
    enabled true
    encrypted_password "password"
    confirmation_token "ABC123"
    remember_token "XYZ890"
  end

end
