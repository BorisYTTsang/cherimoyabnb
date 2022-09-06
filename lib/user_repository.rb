require_relative './user.rb'
require_relative './database_connection.rb'

class UserRepository
  def all
    sql = 'SELECT * FROM users;'
    result = DatabaseConnection.exec_params(sql,[])

    return create_user_object_from_table(result)
  end

  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    return create_user_object_from_table(result)[0]
  end

  def create(user)
    sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3);'
    params = [user.name, user.email, user.password]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  private
  def create_user_object_from_table(result)
    users = []
    result.each do |record|
      user = User.new
      user.id = record['id'].to_i
      user.name = record['name']
      user.email = record['email']
      user.password = record['password']
      users << user
    end
    return users
  end

end