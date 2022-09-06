require "spec_helper"
require "rack/test"
require_relative "../../app"

def reset_users_table
  seed_sql = File.read("spec/seeds/test_seeds/seeds_users.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "chitter_test" })
  connection.exec(seed_sql)
end

def reset_peeps_table
  seed_sql = File.read("spec/seeds/test_seeds/seeds_peeps.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "chitter_test" })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do
    reset_users_table
    reset_peeps_table
  end

  context "/post" do
    it "logs in " do
      
    end
  end