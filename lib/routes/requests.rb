class Application < Sinatra::Base

  user_repo = UserRepository.new
  request_repo = RequestRepository.new

  get "/requests" do
    @user = user_repo.find(session[:user_id])

    @requests = request_repo.all
    return erb(:requests)
  end

end