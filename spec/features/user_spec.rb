require 'rails_helper'
require 'capybara_helper'

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# Capybara.javascript_driver = :selenium;

RSpec.describe "Zz" do

  describe "sign-up shop" do
    let(:shop) { create :user, email: Faker::Internet.email,
                               password: "11111111",
                               password_confirmation: "11111111",
                               shop_title: "Shop",
                               role_id: Role.with_name(:shop).id    }

    before(:each) { login_as(shop) }

    context 'new product'
      before do
        visit (new_product_path)
      end

      it "should have content 'Title'" do
        expect(page).to have_content('Title')
      end

      it 'should not have content "pro"' do
        expect(page).not_to have_css('product_pro')
      end


      it 'should create new product' do
        fill_in('product_title', with: 'Product title')
        sleep 10
        fill_in('product_description', with: "Product description")
        find("input[type=\"submit\"]").click
        expect(page).to have_content('Product was successfully created.')
      end

    end

end
