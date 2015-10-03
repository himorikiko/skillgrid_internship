require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara/rails'

include Warden::Test::Helpers

Warden.test_mode!

Dir[Rails.root.join('spec/support/share_db_connection.rb')].each { |f| require f }


# webdriver for headless JS testing
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

include Warden::Test::Helpers

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
