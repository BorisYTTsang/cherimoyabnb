class Application < Sinatra::Base

  get "/createlisting" do
    user_repo = UserRepository.new
    id = session[:user_id]
    @user = user_repo.find(id)
    return erb(:createlisting)
  end

  # post "/signup" do

  #     repo = UserRepository.new
  #     new_user = User.new
  #     new_user.name = params[:name]
  #     new_user.email = params[:email]
  #     new_user.password = params[:password]
  #     repo.create(new_user)
  #     return erb(:login)

  # end
end