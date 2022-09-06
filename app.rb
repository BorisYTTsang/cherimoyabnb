# Add this above any route class

require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
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