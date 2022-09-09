class Application < Sinatra::Base
  user_repo = UserRepository.new
  space_repo = SpaceRepository.new
  request_repo = RequestRepository.new
  booking_repo = BookingRepository.new


  get '/managerequest' do
    space_id = params[:space_id]
    request_id = params[:request_id]

    @space = space_repo.find(space_id)
    @selectedrequest = request_repo.find(request_id)
    @user = user_repo.find(@selectedrequest.owner_id)
    @booker = user_repo.find(@selectedrequest.booker_id)

    return erb(:managerequest)
  end
    
  post '/confirmbooking' do
    space_id = params[:space_id]
    request_id = params[:request_id]

    @space = space_repo.find(space_id)
    @selectedrequest = request_repo.find(request_id)
    @user = user_repo.find(@selectedrequest.owner_id)
    @booker = user_repo.find(@selectedrequest.booker_id)

    new_booking = Booking.new
    new_booking.space_id = @selectedrequest.space_id
    new_booking.unavailable_from = @selectedrequest.date_from
    new_booking.unavailable_to = @selectedrequest.date_to
    new_booking.reason = 'booking'
    new_booking.booker_id = @selectedrequest.booker_id

    if booking_repo.create(new_booking)
      @success = true
      request_repo.delete(request_id)
      return erb(:managerequest)
    else
      @success = false
      return erb(:managerequest)
    end
  end

  post '/rejectbooking' do
    space_id = params[:space_id]
    request_id = params[:request_id]

    @space = space_repo.find(space_id)
    @selectedrequest = request_repo.find(request_id)
    @user = user_repo.find(@selectedrequest.owner_id)
    @booker = user_repo.find(@selectedrequest.booker_id)

    request_repo.delete(request_id)
    @success = 'rejected'
    return erb(:managerequest)
  end
end