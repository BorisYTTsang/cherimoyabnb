class Application < Sinatra::Base

  get "/makebooking" do
    user_repo = UserRepository.new
    space_repo = SpaceRepository.new
    @user = user_repo.find(session[:user_id])
    @space = space_repo.find(params[:space_id]) #takes the space_id from a hidden value in the listing link
    return erb(:makebooking)
  end

  post "/makebooking" do
      repo = BookingRepository.new
      space_repo = SpaceRepository.new

      @space = space_repo.find(params[:space_id])

      new_booking = Booking.new
      new_booking.space_id = params[:space_id]
      new_booking.unavailable_from = params[:date_from]
      new_booking.unavailable_to = params[:date_to]
      new_booking.reason = 'booking'
      new_booking.booker_id = session[:user_id]
      if repo.create(new_booking)
        @success = true
      else
        @success = false
      end
      return erb(:makebooking)
  end
end