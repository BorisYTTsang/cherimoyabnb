class Application < Sinatra::Base

  get "/requests" do
    return erb(:requests)
  end

end