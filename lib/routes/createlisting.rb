class Application < Sinatra::Base

  get "/createlisting" do
    user_repo = UserRepository.new
    id = session[:user_id]
    @user = user_repo.find(id)
    return erb(:createlisting)
  end

  post "/createlisting" do

      repo = SpaceRepository.new
      new_space = Space.new
      new_space.name = params[:name]
      new_space.description = params[:description]
      new_space.price_per_night = params[:price_per_night]
      new_space.owner_id = params[:owner_id]
      repo.create(new_space)
      return erb(:createlistingsuccess)

  end
end