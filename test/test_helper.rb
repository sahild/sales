ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
   DatabaseCleaner.start
   StripeMock.start
   end
   teardown do
   DatabaseCleaner.clean
   StripeMock.stop
   end
end

require 'mocha/setup'
