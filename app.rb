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

    if password

    session[:user_id] = nil
    session[:user_name] = nil
  
  end

end