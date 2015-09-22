include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    name                  "User"
    email                 "user@example.com"
    password              "secure_password"
    password_confirmation "secure_password"
    avatar                { fixture_file_upload('spec/fixtures/avatar.jpg', 'image/jpg') }
  end
end
