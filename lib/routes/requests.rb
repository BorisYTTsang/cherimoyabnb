class Application < Sinatra::Base



  get "/requests" do

    user_repo = UserRepository.new
    request_repo = RequestRepository.new
    space_repo = SpaceRepository.new

    @user = user_repo.find(session[:user_id])

    @booker_requests = request_repo.find_requests_by_booker_id(@user.id)
    @owner_requests = request_repo.find_requests_by_owner_id(@user.id)
    @spaces = space_repo.all

    return erb(:requests)
  end

end