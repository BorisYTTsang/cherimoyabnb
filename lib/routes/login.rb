class Application < Sinatra::Base

    get "/login" do
      # If invalid credentials entered, @invalid is set to true at bottom before redirected here
      @error_message = nil if @invalid == true
      @invalid = false
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
        # @invalid = true
        # @error_message = "Invalid email address of password"
        redirect "/login"
      end
    end
end