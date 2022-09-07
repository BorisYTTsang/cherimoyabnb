class Application < Sinatra::Base

  get "/makebooking" do
    user_repo = UserRepository.new
    space_repo = SpaceRepository.new
    @user = user_repo.find(session[:user_id])
    @space = space_repo.find(params[:space_id]) #takes the space_id from a hidden value in the Make a Listing button
    return erb(:makebooking)
  end

  post "/makebooking" do
      repo = BookingRepository.new
      new_booking = Booking.new
      new_booking.space_id = session[:space_id]
      new_booking.unavailable_from = params[:unavailable_from]
      new_booking.unavailable_to = params[:unavailable_to]
      new_booking.reason = params[:reason]
      new_booking.booker_id = session[:user_id]
      if repo.create(new_booking)
        return erb(:makebookingsuccess)
      else
        return erb(:makebookingfailure)
      end
  end
end