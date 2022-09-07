class Application < Sinatra::Base

  get "/logout" do
    session[:user_id] = nil
    session[:user_name] = nil
    redirect "/"
  end
end