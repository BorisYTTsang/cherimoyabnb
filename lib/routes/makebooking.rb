require_relative '../space_repository.rb'

class Application < Sinatra::Base
  user_repo = UserRepository.new
  space_repo1 = SpaceRepository.new
  request_repo = RequestRepository.new
  booking_repo = BookingRepository.new

  get "/makebooking" do

    @user = user_repo.find(session[:user_id])
    @space = space_repo1.find(params[:space_id]) #takes the space_id from a hidden value in the listing link

    return erb(:makebooking)
  end

  post "/makerequest" do

    @user = user_repo.find(session[:user_id])

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

    new_booking = Booking.new #Creating a booking object to check for overlap
    new_booking.unavailable_from = request.date_from
    new_booking.unavailable_to = request.date_to
    new_booking.space_id = request.space_id

    if booking_repo.overlaps_existing_booking?(new_booking)
      @request_sent = false
    else
      request_repo.create(request)
      @request_sent = true
    end

    return erb(:makebooking)
  end

end