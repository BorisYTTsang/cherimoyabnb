require_relative '../space_repository.rb'

class Application < Sinatra::Base
  user_repo = UserRepository.new
  space_repo1 = SpaceRepository.new
  request_repo = RequestRepository.new

  get "/makebooking" do

    @user = user_repo.find(session[:user_id])
    @space = space_repo1.find(params[:space_id]) #takes the space_id from a hidden value in the listing link
    @request_sent = false
    return erb(:makebooking)
  end

  post "/makerequest" do

    day_from = params[:date_from].to_s
    month_from = params[:month_from].to_s
    year_from = params[:year_from].to_s
    day_to = params[:date_to].to_s
    month_to = params[:month_to].to_s
    year_to = params[:year_to].to_s
    space_id = params[:space_id].to_s

    
    (month_from = "0" + month_from) if month_from.length == 1
    (day_from = "0" + day_from) if day_from.length == 1
    (month_to = "0" + month_to) if month_to.length == 1
    (day_to = "0" + day_to) if day_to.length == 1


    date_from = "#{year_from}-#{month_from}-#{day_from}"
    date_to = "#{year_to}-#{month_to}-#{day_to}"

    #Add date validity check

    @space = space_repo1.find(params[:space_id]) #takes the space_id from a hidden value in the listing link

    request = Request.new
    request.space_id = @space.id
    request.owner_id = @space.owner_id
    request.booker_id = session[:user_id]
    request.date_from = date_from
    request.date_to = date_to
    request.booked = 'false'
    request_repo.create(request)

    @user = user_repo.find(session[:user_id])
    @request_sent = true
    return erb(:makebooking)
  end

end