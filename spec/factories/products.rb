FactoryGirl.define do
  factory :product do
    title                 Faker::Commerce.product_name
    description           Faker::Lorem.paragraphs(1)
  end
end
