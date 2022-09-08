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
    date_from = params[:date_from]
    date_to = params[:date_to]
    space_id = params[:space_id]

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