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

  post "/make-request" do
    date_from = params[:date_from]
    date_to = params[:date_to]
    space_id = params[:space_id]

    @space = space_repo1.find(params[:space_id]) #takes the space_id from a hidden value in the listing link

    request = Request.new
    request.space_id = @space.id
    request.owner_id = @space.owner_id
    request.booker_id = session[:user_id]
    request.booked = 'false'
    request_repo.create(request)

    @user = user_repo.find(session[:user_id])
    @request_sent = true
    return erb(:makebooking)
  end

  #post "/makebooking" do
  #     repo = BookingRepository.new
  #     space_repo = SpaceRepository.new

  #     @space = space_repo.find(params[:space_id])

  #     new_booking = Booking.new
  #     new_booking.space_id = params[:space_id]
  #     new_booking.unavailable_from = params[:date_from]
  #     new_booking.unavailable_to = params[:date_to]
  #     new_booking.reason = 'booking'
  #     new_booking.booker_id = session[:user_id]
  #     if repo.create(new_booking)
  #       @success = true
  #     else
  #       @success = false
  #     end
  #     return erb(:makebooking)
  # end
end