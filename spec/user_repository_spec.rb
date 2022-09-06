require 'user_repository'

def reset_users_table
    seed_sql = File.read('spec/seeds/users_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
    connection.exec(seed_sql)
end

def reset_spaces_table
    seed_sql = File.read('spec/seeds/spaces_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
    connection.exec(seed_sql)
end
  
RSpec.describe UserRepository do
    before(:each) do 
      reset_users_table
      reset_spaces_table
    end
  
    describe '# all' do
        it 'Get all users and checks for id one and two' do
            repo = UserRepository.new

            users = repo.all

            expect(users.length).to eq 6

            expect(users[0].id).to eq 1
            expect(users[0].name).to eq 'Joe'
            expect(users[0].email).to eq 'joe@example.com'
            expect(users[0].password).to eq 'password123'

            expect(users[1].id).to eq 2
            expect(users[1].name).to eq 'Sarah'
            expect(users[1].email).to eq 'saarah777@example.com'
            expect(users[1].password).to eq 'pass90@!'
        end
    end

    describe '# find' do
        it 'returns user with id one' do

            repo = UserRepository.new

            user = repo.find(1)

            expect(user.id).to eq 1
            expect(user.name).to eq 'Joe'
            expect(user.email).to eq 'joe@example.com'
            expect(user.password).to eq 'password123'
        end
        it 'returns user with id 5' do
            repo = UserRepository.new

            user = repo.find(5)

            expect(user.id).to eq 5
            expect(user.name).to eq 'Gurpreet'
            expect(user.email).to eq 'gurpreet.singh@example.com'
            expect(user.password).to eq 'chrysanthemum1'
        end
    end 

    describe '#find_by_name' do
        it 'Finds by username Joe' do
            repo = UserRepository.new

            user = repo.find_by_name('Joe')

            expect(user.id).to eq 1
            expect(user.name).to eq 'Joe'
            expect(user.email).to eq 'joe@example.com'
            expect(user.password).to eq 'password123'
        end
    end



    describe '#create' do
        it 'creates a new user' do

            repo = UserRepository.new


            new_user = User.new
            new_user.name = 'John'
            new_user.email = 'john@example.com'
            new_user.password = 'password1'

            repo.create(new_user)

            all_users = repo.all

            expect(all_users.last.name).to eq 'John'
            expect(all_users.last.email).to eq 'john@example.com'
            expect(all_users.last.password).to eq 'password1'
        end
    end 
end