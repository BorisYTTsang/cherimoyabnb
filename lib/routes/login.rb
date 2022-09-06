class Application < Sinatra::Base

    get "/login" do
        return erb(:login)
    end

    post "/login" do
        email = params[:email]
        password = params[:password]
        users_repo = UserRepository.new
        user = users_repo.find_by_email(email)
        if !user.nil? && user.password == password
          session[:user_id] = user.id
          session[:user_name] = user.name
          return erb(:login_success)
        else
          return erb(:login_failure)
        end
    end
end