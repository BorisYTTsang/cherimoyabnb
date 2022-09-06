require "spec_helper"
require "rack/test"
require_relative "../../app"

def reset_users_table
  seed_sql = File.read("spec/seeds/seeds_users.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "cherimoyabnb_test" })
  connection.exec(seed_sql)
end

def reset_spaces_table
  seed_sql = File.read("spec/seeds/seeds_tables.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "cherimoyabnb_test" })
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
    reset_spaces_table
  end

  context "GET /" do
    it "redirects to login page" do
      response = get("/")
      expect(response.status).to eq 302
    end
  end

  context "GET /login" do
    it "goes to login page" do
      response = get("/login")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login</h1>')
    end
  end

  context "POST /login" do
    it "logs registered user in" do
      response = post("/login", email: "joe@example.com", password: "password123")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login Success!</h1>')
      response = post("/login", email: "gurpreet.singh@example.com", password: "chrysanthemum1")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login Success!</h1>')
    end

    it "directs to login failure page when email is not registered" do
      response = post("/login", email: "cyan@example.com", password: "password123")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login Failure!</h1>')
    end

    it "directs to login failure page when password is incorrect" do
      response = post("/login", email: "joe@example.com", password: "password12")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login Failure!</h1>')
    end

    it "directs to login failure page when login fields left empty" do
      response = post("/login")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login Failure!</h1>')
    end
  end
end