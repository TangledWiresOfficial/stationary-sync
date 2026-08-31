ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    teardown do
      log_out
    end

    # Add more helper methods to be used by all tests here...

    # Authenticate as a user
    # @param [User] user
    def auth_as(user)
      Utils::Auth.test_data = { sub: user.uid }
    end

    # Log out
    def log_out
      Utils::Auth.test_data = nil
    end
  end
end
