class Application < Sinatra::Base

  space_repo = SpaceRepository.new

  get "/viewlistings" do
    # write rspec tests first
  end

  post "/dashboard" do
    #delete listing
  end

  get "/listing/:space_id/update" do
    #update listing
  end
  
end