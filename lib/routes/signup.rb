class Application < Sinatra::Base

    get "/signup" do
        return erb(:signup)
    end

    post "/signup" do
        repo = UserRepository.new
        new_user = User.new
        new_user.name = params[:name]
        new_user.email = params[:email]
        new_user.password = params[:password]
        repo.create(new_user)
        return erb(:login)
    end
end