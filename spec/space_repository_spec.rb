require 'space_repository'


def reset_spaces_table
    seed_sql = File.read('spec/spaces_seed.sql')
    connection = PG.connect ({ host: '127.0.0.1', dbname: 'cherimoyabnb_test'})
    connection.exec(seeq_sql)
end

describe SpaceRepository do
    before(:each) do
        reset_spaces_table
    end

    describe '#all' do
        it 'returns array with all records' do
            repo = SpaceRepository.new

            spaces = repo.all

            expect(spaces.length).to eq 11

            (spaces[0].id).to eq 1
            (spaces[0].name).to eq 'Beautiful Seaside Cottage in Hastings'
            (spaces[0].description).to eq 'Located 15 minutes from the St Leonards-on-Sea seafront. A beautiful seaside residence with open-plan kitchen, oak wooden floors, and charming garden. Excellent for a relaxing seaside retreat.'
            (spaces[0].price_per_night).to eq '40'
            (spaces[0].owner_id).to eq '3'
            

            (spaces[1].id).to eq 2
            (spaces[1].name).to eq 'Villa Adjacent to Lake in Porthcurno'
            (spaces[1].description).to eq 'A large veranda and decking area with two hammocks, perfect for relaxing. Open plan lounge and kitchen with fridge-freezer. Two bedrooms, two bathrooms. Parking spaces available.'
            (spaces[1].price_per_night).to eq '32'
            (spaces[1].owner_id).to eq '1'
        end    
    end

    describe '#find' do
        it 'finds a space' do
            repo = SpaceRepository.new

            space = repo.find(1)

            (space.id).to eq 1
            (space.name).to eq 'David'
            (space.description).to eq 'April 2022'
            (space.price_per_night).to eq 'April 2022'
            (space.owner_id).to eq 'April 2022'
            
        end
        
    end

    describe '#create' do
        it 'creates a new space' do
            repo = SpaceRepository.new

            new_space = Space.new
        
            new_space.name # => 'York'
            new_space.description # => '12/09/2022'
            new_space.price_per_night # => '26/09/2022'
            new_space.owner_id # => 'Rented out'
        
        
            repo.create(new_space)
        
            space = repo.all.last
        
            expect(space.name).to eq 'York'
            expect(space.description).to eq '12/09/2022'
            expect(space.price_per_night).to eq '26/09/2022'
            expect(space.owner_id).to eq '3'
        end

    end
        
    describe '#delete' do
        it 'returns deleted record' do

        end
    end

end