# Add this above any route class

require 'sinatra/base'
require 'sinatra/reloader'

require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'
require_relative 'lib/request_repository'
require_relative 'lib/space_repository'
require_relative 'lib/user_repository'

require_relative 'lib/routes/login'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/booking_repository'
    also_reload 'lib/request_repository'
    also_reload 'lib/space_repository'
    also_reload 'lib/user_repository'
    
  end

  enable :sessions

  get "/" do
    return erb(:login)
  end

  post "/login" do
    email = params[:email]
    password = params[:password]
    users_repo = UserRepository.new
    user = users_repo.find_by_email(email)
    if !user.nil? && user.password == password
      session[:user_id] = user.id
      session[:user_name] = user.name
      return login_success.erb
    else
      redirect "/" # should return login_failure.erb
    end
  end

end