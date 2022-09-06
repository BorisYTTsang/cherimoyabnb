# Add this above any route class

require 'sinatra/base'
require 'sinatra/reloader'

require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'
require_relative 'lib/request_repository'
require_relative 'lib/space_repository'
require_relative 'lib/user_repository'

require_relative 'lib/routes/login'

DatabaseConnection.connect

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
  
  # This is for changing the /views folder location from default to /lib/routes/views
  set :root,  File.dirname(__FILE__)
  set :views, Proc.new { File.join(root, 'lib', 'routes', 'views') }

  enable :sessions

  get "/" do
    redirect "/login"
  end

  # subsequent routes can be found in /lib/routes files

end