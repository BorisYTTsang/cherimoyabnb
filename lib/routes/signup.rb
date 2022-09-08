class Application < Sinatra::Base

    get "/signup" do
         # If existing email entered, error message on redirect
        @error_message_signup = nil
        return erb(:signup)
    end

    post "/signup" do
        users_repo = UserRepository.new
        # Backend user input validation in tandem with frontend in erb files, ordering is important to pass RSpec tests
        fail "Javascript detected!" unless users_repo.script_free?(params[:name])
        fail "Javascript detected!" unless users_repo.script_free?(params[:email])
        fail "Javascript detected!" unless users_repo.script_free?(params[:password])
        fail "Invalid password detected!" unless users_repo.password_valid?(params[:password])
        user = users_repo.find_by_email(params[:email])
        if user.nil?
            new_user = User.new
            new_user.name = params[:name]
            new_user.email = params[:email]
            new_user.password = params[:password]
            users_repo.create(new_user)
            return erb(:signup_success)
        else
            @error_message_signup = "Apologies, that email address already belongs to an account."
            return erb(:signup)
        end
    end
end