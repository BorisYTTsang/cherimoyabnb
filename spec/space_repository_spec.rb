require 'space_repository'

def reset_spaces_table
    seed_sql = File.read('spec/spaces_seed.sql')
    connection = PG.connect ({ host: '127.0.0.1', dbname: 'cherimoyabnb_test'})
    connection.exec(seed_sql)
end

describe SpaceRepository do
    before(:each) do
        reset_spaces_table
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
          
          expect(finder.all.name).to eq("meep")
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

end