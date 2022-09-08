class Application < Sinatra::Base

  user_repo = UserRepository.new
  request_repo = RequestRepository.new

  get "/requests" do
    @user = user_repo.find(session[:user_id])
    space_repo = SpaceRepository.new
    @booker_requests = request_repo.find_requests_by_booker_id(@user.id)
    @owner_requests = request_repo.find_requests_by_owner_id(@user.id)
    @spaces = space_repo.all
    return erb(:requests)
  end

end