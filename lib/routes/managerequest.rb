class Application < Sinatra::Base
  user_repo = UserRepository.new
  space_repo = SpaceRepository.new
  request_repo = RequestRepository.new
  booking_repo = BookingRepository.new


  get '/manage-request' do
    space_id = params[:space_id]
    request_id = params[:space_id]

    @space = space_repo.find(space_id)
    @request = request_repo.find(request_id)
    @user = user_repo.find(@request.owner_id)
    return erb(:managerequest)
  end
    
  post 'make-booking' do
    space_id = params[:space_id]
    request_id = params[:space_id]

    @space = space_repo.find(space_id)
    @request = request_repo.find(request_id)

    new_booking = Booking.new
    new_booking.space_id = @request.space_id
    new_booking.unavailable_from = @request.date_from
    new_booking.unavailable_to = @request.date_to
    new_booking.reason = 'booking'
    new_booking.booker_id = @request.booker_id

    if repo.create(new_booking)
      @success = true
    else
      @success = false
    end
    return erb(:makebooking)

    return erb(:managerequest)
  end
end