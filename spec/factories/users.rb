FactoryGirl.define do
  factory :user do
    name                  "User"
    email                 "user@example.com"
    password              "secure_password"
    password_confirmation "secure_password"
  end
end
