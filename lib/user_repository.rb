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

  def find_by_name(name)
    sql = 'SELECT * FROM users WHERE name = $1;'
    params = [name]
    result = DatabaseConnection.exec_params(sql, params)

    return create_user_object_from_table(result)[0]
  end

  def create(user)
    if find_by_email(user.email).nil?
      sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3);'
      params = [user.name, user.email, user.password]
      DatabaseConnection.exec_params(sql, params)
    end

    return nil
  end

  def find_by_email(email)
    sql = "SELECT * FROM users WHERE email = $1;"
    result = DatabaseConnection.exec_params(sql, [email])

    users = all # call #all method for any? method below
    return nil unless users.any? { |user| user.email == email }

    return create_user_object_from_table(result)[0]
  end

  # At least 8 characters, a symbol, a digit(integer), lowercase and uppercase, no spaces
  def password_valid?(password)
    if password.length >= 8 && !(password =~ /\W/).nil? && !(password =~ /\d/).nil? && !(password =~ /[A-Z]/).nil? && !(password =~ /[a-z]/).nil? && !password.include?(' ')
      return true
    else
      return false
    end
  end

  # Returns true if javascript injection is detected in user-originating input (string)
  def script_free?(string)
    if string.include?("<script>") || string.include?("</script>")
      return false
    else
      return true
    end
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
