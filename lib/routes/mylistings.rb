class Application < Sinatra::Base

  space_repo = SpaceRepository.new

  get "/mylistings" do
    if session[:user_id].nil?
      redirect "/login"
    else
      @my_listings = space_repo.find_by_owner(session[:user_id])
      return erb(:mylistings)
    end
  end

  post "/dashboard" do
    #delete listing
  end

  get "/listing/:space_id/update" do
    #update listing
  end
  
end