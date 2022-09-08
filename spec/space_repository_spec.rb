require 'space_repository'


def reset_all
    userseed_sql = File.read('spec/seeds/users_seed.sql')
    spaceseed_sql = File.read('spec/seeds/spaces_seed.sql')
    requestseed_sql = File.read('spec/seeds/requests_seed.sql')
    bookingseed_sql = File.read('spec/seeds/bookings_seed.sql')

    connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
    connection.exec(users_seed.sql)
    connection.exec(spaces_seed.sql)
    connection.exec(requests_seed.sql)
    connection.exec(bookings_seed.sql)
end


describe SpaceRepository do

    before(:each) do 
      reset_all
    end

    describe '#all' do
        it 'returns array with all records' do
            spaces_repo = SpaceRepository.new
            expect(spaces_repo.all.size).to eq 11    
            expect(spaces_repo.all.first.name).to eq('Beautiful Seaside Cottage in Hastings')
            expect(spaces_repo.all.first.id).to eq(1)
        end    
    end
        
    describe '#find' do
        it 'finds a space' do
          spaces_repo = SpaceRepository.new
          finder = spaces_repo.find(3)
          expect(finder.name).to eq('3 Bedroom Flat located in Central London. ')
          expect(finder.id).to eq('3')
      end 
    end

    describe '#find_by_name' do
        it 'finds a space by name' do
          spaces_repo = SpaceRepository.new
          finder = spaces_repo.find_by_name('3 Bedroom Flat located in Central London. ')
          expect(finder.name).to eq('3 Bedroom Flat located in Central London. ')
          expect(finder.id).to eq('3')
      end 
    end
    
    describe '#create' do
        it 'creates a new space' do
            spaces_repo = SpaceRepository.new
            new_space = Space.new
            new_space.name = "Test name1"
            new_space.description = "Test description1"
            new_space.price_per_night = "1000000"
            new_space.owner_id = "6"
            spaces_repo.create(new_space)
            expect(spaces_repo.all[11].name).to eq('Test name1')
        end
    end

    describe '#delete' do
        it 'returns deleted record' do
            spaces_repo = SpaceRepository.new
            expect(spaces_repo.delete(11).name).to eq('Scenic Guest suite in Kingston Vale')
            expect(spaces_repo.all.size).to eq 10
            spaces_repo.delete(10)
            expect(spaces_repo.all.size).to eq 9
        end
    end

    describe '#filter' do
        context "if max price is £35, then £70" do
            it 'returns an array of 2, then 8 records respectively' do
                  spaces_repo = SpaceRepository.new
                  expect(spaces_repo.filter("2022-01-01", "2022-01-02", "35").size).to eq 2
                  expect(spaces_repo.filter("2022-01-01", "2022-01-02", "70").size).to eq 8
            end
        end
       
        context 'if filter min and max days do not coincide with any unavailable dates, and max price £300' do
            it 'returns array with all spaces (size 11)' do
                spaces_repo = SpaceRepository.new
                new_book = Booking.new
                bookings = BookingRepository.new
                result = spaces_repo.filter("2022-01-03","2022-08-15","300")
                expect(result.size).to eq 11
                expect(result[0].name).to eq("Beautiful Seaside Cottage in Hastings")
            end
        end
       
        context 'if min_date is 2022-09-01 and max_date is 2022-09-30, max price £300 ' do
            it 'returns an array with 10 records (despite one space having two consecutive bookings)' do
                spaces_repo = SpaceRepository.new
                new_book = Booking.new
                bookings = BookingRepository.new
                result = spaces_repo.filter('2022-09-01','2022-09-30',"300")
                expect(result.size).to eq 10
                result = spaces_repo.filter('2022-09-01','2023-01-01',"300")
                expect(result.size).to eq 7
            end
        end
    end
end


class ResetTables
      
    

  end