require_relative './user.rb'
require_relative './database_connection.rb'

class UserRepository
  def all
    sql = 'SELECT * FROM users;'
    result = DatabaseConnection.exec_param(sql,[])

    users = []

    result.each do |record|
      user = User.new
      user.id = record['id']
      user.name = record['name']
      user.email = record['email']
      user.password = record['password']
      users << user
    end

    return users
  end

  def find(id)
    # Executes the SQL query:
    # SELECT * FROM users WHERE id = $1;

    # Returns a single user object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(user)
    # INSERT INTO users (name, email, password) VALUES ($1, $2, $3);
    # returns nothing
  end

  # def update(user)
  # end

  # def delete(user)
  # end
end