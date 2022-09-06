class App < Sinatra::Base

    get "/login" do
        return erb(:login)
    end

    post "/login" do

        #stuff to do when they input user,pass
    end
end