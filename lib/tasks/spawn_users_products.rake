namespace :db do
  desc "Fill database with sample users"
  task spawn_users_and_products: :environment do
    User.create!(name: "User",
                 email: "example@example.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password  = "password"
      user = User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      5.times do |m|
        title = Faker::Commerce.product_name
        desc = Faker::Lorem.paragraphs(1)
        product = user.products.create!(title: title, description: desc)
      end
    end
  end
end
