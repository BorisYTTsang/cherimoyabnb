class Application < Sinatra::Base

  get "/makebooking" do
    user_repo = UserRepository.new
    space_repo = SpaceRepository.new
    @user = user_repo.find(session[:user_id])
    @space = space_repo.find(session[:space_id])
    return erb(:makebooking)
  end

  # post "/makebooking" do
  #     repo = BookingRepository.new
  #     new_booking = Booking.new
  #     new_booking.space_id = session[:space_id]
  #     new_booking.unavailable_from = params[:unavailable_from]
  #     new_booking.unavailable_to = params[:unavailable_to]
  #     new_booking.reason = params[:reason]
  #     new_booking.booker_id = session[:user_id]
  #     repo.create(new_booking)
  #     return erb(:createlistingsuccess)
  # end
end