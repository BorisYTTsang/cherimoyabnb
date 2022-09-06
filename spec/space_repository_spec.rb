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
            spaces_repo = SpaceRepository.new
            expect(space_repo.all.size).to eq 11    
        end    
    end

    describe '#find' do
        it 'finds a space'
            
        end
        
    end

    describe '#create' do

    end
        
    describe '#delete' do
        it 'returns deleted record' do

        end
    end

end