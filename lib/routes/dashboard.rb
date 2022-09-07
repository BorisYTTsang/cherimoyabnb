class Application < Sinatra::Base

  repo = SpaceRepository.new

  get "/dashboard" do
      if session[:user_id].nil?
        redirect "/login"
      else
        @user_name = session[:user_name]
        @spaces_booked
        @spaces = repo.all
        return erb(:dashboard)
      end
  end

  post "/dashboard" do
    available_from = params[:available_from]
    available_to = params[:available_to]
    max_price = params[:max_price]
    filtered_bookings = repo.filter(available_from,available_to,max_price)
    return erb(:dashboard)
  end
end