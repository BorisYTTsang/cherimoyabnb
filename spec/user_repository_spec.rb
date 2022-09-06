require 'user_repository'
def reset_users_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe UserRepository do
    before(:each) do 
      reset_users_table
    end
  
describe '# all' do

# 1
# Get all users
    it 'Get all users and checks for id one and two' do
        repo = UserRepository.new

        users = repo.all

        users.length # =>  2

        expect(users[0].id).to eq 1
        expect(users[0].name).to eq 'David'
        expect(users[0].email).to eq 'April 2022'
        expect(users[0].password).to eq 'April 2022'


        expect(users[1].id).to eq 2
        expect(users[1].name).to eq 'Anna'
        expect(users[1].email).to eq 'May 2022'
        expect(users[1].password).to eq 'May 2022'
    end
end

# 2
# Get a single user
describe '# find' do
    it 'returns user with id one' do

        repo = UserRepository.new

        user = repo.find(1)

        expect(user.id).to eq 1
        expect(user.name).to eq 'David'
        expect(user.email).to eq 'April 2022'
        expect(user.password).to eq 'April 2022'
    end
end 

# Add more examples for each method

# 3 
# Creates a new user
describe '#create' do
    it 'creates a new user' do

        repo = UserRepository.new


        new_user = User.new

        new_user.name # => 'John'
        new_user.email # => 'john@email.com'
        new_user.password # => 'password1'

        repo.create(new_user)

        user = repo.all.last

        expect(user.name).to eq 'John'
        expect(user.email).to eq 'john@email.com'
        expect(user.password).to eq 'password1'
    end
end 

end