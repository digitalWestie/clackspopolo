FactoryGirl.define do
  factory :admin do
    email "user@example.org"
    password 'somepassword'
    encrypted_password Devise.bcrypt(Admin, 'somepassword')
  end
end