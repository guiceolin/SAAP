ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/ansi'

require 'coveralls'
Coveralls.wear!('rails')

require 'database_cleaner'
DatabaseCleaner.strategy = :transaction

MiniTest::ANSI.use!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
