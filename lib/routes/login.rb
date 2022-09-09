class Application < Sinatra::Base

    get "/login" do
      # If invalid credentials entered, error message on redirect
      @error_message_login = nil
      return erb(:login)
    end

    post "/login" do
      email = params[:email]
      password = params[:password]
      users_repo = UserRepository.new
      if !email.nil? && !password.nil?
        fail "Javascript detected!" unless users_repo.script_free?(params[:email])
        fail "Javascript detected!" unless users_repo.script_free?(params[:password])
      end

      user = users_repo.find_by_email(email)
      
      if !user.nil? && user.password == password
        session[:user_id] = user.id
        session[:user_name] = user.name
        return erb(:login_success)
      else
        @error_message_login = "Invalid email address or password, please try again."
        return erb(:login)
      end
    end
end