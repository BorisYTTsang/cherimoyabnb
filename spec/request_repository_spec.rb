require 'request_repository'

def reset_requests_table
    seed_sql = File.read('spec/seeds_requests.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'requests' })
    connection.exec(seed_sql)
  end
  
RSpec.describe RequestRepository do
    before(:each) do 
      reset_requests_table
    end
  
    # 1
    # Get all requests
    describe '# get' do
        xit 'gets all request' do

            repo = RequestRepository.new

            requests = repo.all

            requests.length # =>  2

            expect(requests[0].id).to eq 1
            expect(requests[0].space_id).to eq 'David'
            expect(requests[0].user_id).to eq 'April 2022'
            expect(requests[0].booker_id).to eq 'April 2022'
            expect(requests[0].booked_id).to eq 'April 2022'

            expect(requests[1].id).to eq 2
            expect(requests[1].space_id).to eq 'Anna'
            expect(requests[1].user_id).to eq 'May 2022'
            expect(requests[1].booker_id).to eq 'April 2022'
            expect(requests[1].booked_id).to eq 'April 2022'
        end
    end

    # 2
    # Get a single request
    describe '# find' do
        xit 'finds and returns a single request' do
            repo = RequestRepository.new

            request = repo.find(1)

            expect(request.id).to eq 1
            expect(request.space_id).to eq 'David'
            expect(request.user_id).to eq 'April 2022'
            expect(request.booker_id).to eq 'April 2022'
            expect(request.booked).to eq 'April 2022'
        end
    end

    # 3 
    # create a new request
    describe '#create' do
        xit 'creates a new request' do
            new_requests = Request.new

            new_request.space_id # => 'York'
            new_request.user_id # => '12/09/2022'
            new_request.booker_id # => '26/09/2022'
            new_request.booked # => 'Rented out'


            repo.create(new_request)

            request = repo.all.last

            expect(request.space_id).to eq 'York'
            expect(request.user_id).to eq '12/09/2022'
            expect(request.booker_id).to eq '26/09/2022'
            expect(request.booked).to eq 'Rented out'
        end
    end

end