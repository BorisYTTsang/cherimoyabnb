class UserRepository
    def all
        users = []
        sql = 'SELECT * FROM users;'
        result_set = DatabaseConnection.exec_params(sql, [])
        
        result_set.each do |record|
            user = User.new
            user.id = record['id'].to_i
            user.name = record['name']
            user.email = record['email']
            user.password = record['password']
            
            users << user
        end
        
        return users
    end

    def find(id)
        sql = 'SELECT * FROM users WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)
        user = User.new
        user.id = result_set.id
        user.name = result_set.name
        user.email = result_set.email
        user.password = result_set.password

        return user
    end

    def create(user)
        sql = 'INSERT INTO users (name, email, password) VALUES ($1,$2,$3);'
        result_set = DatabaseConnection.exec_params(sql, [user.name, user.email, user.password])

        return nil
    end
end