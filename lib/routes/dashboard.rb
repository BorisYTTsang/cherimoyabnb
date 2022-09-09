class Application < Sinatra::Base

  space_repo = SpaceRepository.new

  get "/dashboard" do
      (redirect "/login") if session[:user_id].nil?
      if params[:available_from].nil?
        @user_name = session[:user_name]
        @spaces = space_repo.all
        return erb(:dashboard)
      else
        @spaces = []
        space_repo = SpaceRepository.new
        available_from = params[:available_from]
        available_to = params[:available_to]
        max_price = params[:max_price]
    
        @user_name = session[:user_name]
        
        @filtered_spaces = space_repo.filter(available_from, available_to, max_price)
    
        return erb(:dashboard)
      end
  end

end