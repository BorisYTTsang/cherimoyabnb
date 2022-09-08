ENV['APP_ENV'] = 'test'

require "spec_helper"
require "rack/test"
require 'test/unit'
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

  context "route: GET /" do
    it "redirects to login page when not logged in" do
      response = get("/")
      expect(response.status).to eq 302
      expect(response.header['Location']).to include('/login')
    end
    
    it "redirects to dashboard when logged in" do
      response = post("/login", email: "joe@example.com", password: "password123")
      response = get("/")
      expect(response.status).to eq 302
      expect(response.header['Location']).to include('dashboard')
    end
  end

  context "route: GET /login" do
    it "goes to login page" do
      response = get("/login")
      expect(response.status).to eq 200
      expect(response.body).to include('<div class="login-header-img"></div>')
    end
  end

  context "route: GET /signup" do
    it "returns signup page" do
        response = get("/signup")

        expect(response.status).to eq(200)
    end
  end

  context "route: POST /signup" do
    it "signs up new user" do
      response = post("/signup")
      expect(response.status).to eq(200)

      response = post("/signup",name:"meep1",email:"meep2",password:"meep3")
    
      repo = UserRepository.new
      users = repo.all
      expect(users[-1].name).to eq("meep1")
      expect(users[-1].email).to eq("meep2")
      expect(users[-1].password).to eq("meep3")
    end
  end
  
  context "route: POST /login" do
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

  context "route: GET /createlisting" do
    it 'returns the create listing page with input form' do
      response = post("/login", email: "joe@example.com", password: "password123")
      response = get("/createlisting")
      
      expect(response.status).to eq 200
      expect(response.body).to include 'Name of property:'
      expect(response.body).to include 'action="/createlisting" method="POST"'
    end
  end

  context "route: POST /createlisting" do
    it 'creates a listing if the listing does not already exist' do
      response = post("/login", email: "joe@example.com", password: "password123")
      response = post("/createlisting", name: "Lovely place", description: "Has a roof", price_per_night: 68, owner_id: 3)
      expect(response.status).to eq 200
      expect(response.body).to include "Your space has been successfully added as a listing"
    end
    it 'adds space to database' do
      response = post("/login", email: "joe@example.com", password: "password123")
      response = post("/createlisting", name: "Lovely place", description: "Has a roof", price_per_night: 68, owner_id: 3)
      expect(response.status).to eq 200
      expect(response.body).to include "Your space has been successfully added as a listing"
      space_repo = SpaceRepository.new
      expect(space_repo.all.last.name).to eq "Lovely place"
    end
  end

  context "route: GET /makebooking" do
    it 'Returns the make booking page' do
      response = post("/login", email: "joe@example.com", password: "password123")
      response = get("/makebooking", space_id: 1)
      expect(response.status).to eq 200
      expect(response.body).to include 'Submit a new booking request'
    end
    it 'Returns a booking page for a specific property' do
      response = post("/login", email: "joe@example.com", password: "password123")
      response = get("/makebooking", space_id: 1)
      expect(response.status).to eq 200
      expect(response.body).to include 'Beautiful Seaside Cottage in Hastings'
    end
  end

  context "route: GET /logout" do
    it "logs user out of session and redirects to /" do
      response = get("/logout")
      expect(response.status).to eq 302
      expect(response.header["Location"]).to eq "http://example.org/"
      response = get("/dashboard")
      expect(response.status).to eq 302
    end
  end
  
  context "route: GET /dashboard" do
    it "returns dashboard when logged in" do
      post("/login", email: "massivelykinjang@example.com", password: "d@d@!123")
      response = get("/dashboard")
      expect(response.status).to eq 200
      expect(response.body).to include('<body class="dashboard">')
    end

    it "redirects to /login when not logged in" do
      response = get("/dashboard")
      expect(response.status).to eq 302
      expect(response.header['Location']).to include('/login')
    end
  end
  context "route: POST /dashboard" do
    it "Returns a filtered list of properties when dates and price entered" do
      post("/login", email: "massivelykinjang@example.com", password: "d@d@!123")
      response = post("/dashboard", available_from: "2022-01-01", available_to: "2022-01-02", max_price: "70")
      expect(response.status).to eq 200
      expect(response.body).to include "Villa Adjacent to Lake in Porthcurno"
    end
  end

  context "route: POST /makebooking" do
    it 'Returns the makebooking page after a booking' do
      response = post("/makebooking", space_id: 1, unavailable_from: '2022-01-01', unavailable_to: '2022-01-02', booker_id: 3)
      expect(response.status).to eq 200
      expect(response.body).to include 'Submit a new booking request'
    end
    xit 'Returns the makebooking page with a success prompt after a booking request' do
      response = post("/makebooking", space_id: 1, unavailable_from: '2022-01-01', unavailable_to: '2022-01-02', booker_id: 3)
      expect(response.status).to eq 200
      expect(response.body).to include 'Your booking request was sent!'
    end
    xit 'Returns the makebooking page with a failure prompt after a booking request' do
      response = post("/makebooking", space_id: 1, unavailable_from: '2022-01-01', unavailable_to: '2022-01-02', booker_id: 3)
      expect(response.status).to eq 200
      expect(response.body).to include 'Your booking request failed, the booking overlaps an existing booking. Please try again.'
    end
  end

  context "route: GET /requests" do
    it 'Returns the requests page' do
      response = get('/requests')
      expect(response.status).to eq 200
      expect(response.body).to include "Requests I've received"
    end
  end
end