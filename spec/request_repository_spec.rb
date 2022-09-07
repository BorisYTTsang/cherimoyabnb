require 'request_repository'
require 'request'

def reset_requests_table
    seed_sql = File.read('spec/seeds/requests_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
    connection.exec(seed_sql)
end
  
RSpec.describe RequestRepository do
    before(:each) do 
      reset_requests_table
    end
  
    # 1
    # Get all requests
    describe '# get' do
        it 'gets all request' do

            repo = RequestRepository.new

            requests = repo.all

            expect(requests.length).to eq 7

            expect(requests[0].id).to eq 1
            expect(requests[0].space_id).to eq '2'
            expect(requests[0].owner_id).to eq '1'
            expect(requests[0].booker_id).to eq '4'
            expect(requests[0].booked).to eq 'false'

            expect(requests[1].id).to eq 2
            expect(requests[1].space_id).to eq '8'
            expect(requests[1].owner_id).to eq '3'
            expect(requests[1].booker_id).to eq '2'
            expect(requests[1].booked).to eq 'false'
        end
    end

    # 2
    # Get a single request
    describe '# find' do
        it 'finds and returns a single request' do
            repo = RequestRepository.new

            request = repo.find(1)

            expect(request.id).to eq 1
            expect(request.space_id).to eq '2'
            expect(request.owner_id).to eq '1'
            expect(request.booker_id).to eq '4'
            expect(request.booked).to eq 'false'
        end
    end

    # 3 
    # create a new request
    describe '#create' do
        it 'creates a new request' do
            new_request = Request.new
            repo = RequestRepository.new

            new_request.space_id = '9'
            new_request.owner_id = '3'
            new_request.booker_id = '4'
            new_request.booked = 'false'


            repo.create(new_request)

            request = repo.all.last

            expect(request.space_id).to eq '9'
            expect(request.owner_id).to eq '3'
            expect(request.booker_id).to eq '4'
            expect(request.booked).to eq 'false'
        end
    end

end