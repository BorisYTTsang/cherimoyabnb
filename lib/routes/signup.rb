class Application < Sinatra::Base

    get "/signup" do
        return erb(:signup)
    end

    post "/signup" do
        repo = UserRepository.new
        # Backend user input validation in tandem with frontend in erb files, ordering is important to pass RSpec tests
        fail "Javascript detected!" unless repo.script_free?(params[:name])
        fail "Javascript detected!" unless repo.script_free?(params[:email])
        fail "Javascript detected!" unless repo.script_free?(params[:password])
        fail "Invalid password detected!" unless repo.password_valid?(params[:password])
        new_user = User.new
        new_user.name = params[:name]
        new_user.email = params[:email]
        new_user.password = params[:password]
        repo.create(new_user)
        return erb(:signup_success)
    end
end