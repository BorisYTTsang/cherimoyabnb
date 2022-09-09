class Application < Sinatra::Base

  space_repo = SpaceRepository.new

  get "/dashboard" do
      if session[:user_id].nil?
        redirect "/login"
      else
        @user_name = session[:user_name]
        @spaces_booked
        @spaces = space_repo.all
        return erb(:dashboard)
      end
  end

  post "/dashboard" do

    space_repo = SpaceRepository.new
    available_from = params[:available_from]
    available_to = params[:available_to]
    max_price = params[:max_price]

    @user_name = session[:user_name]
    
    @filtered_spaces = space_repo.filter(available_from, available_to, max_price)

    redirect "/dashboard"
    # return erb(:dashboard)
  end
  
end