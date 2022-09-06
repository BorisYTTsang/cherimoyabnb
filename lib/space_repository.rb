require_relative 'space.rb'

class SpaceRepository

    def all
        spaces = []
        sql = 'SELECT * FROM spaces;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            space = Space.new
            space.id = record['id'].to_i
            space.name = record['name']
            space.description = record['description']
            space.price_per_night = record['price_per_night']
            space.owner_id = record['owner_id']

            spaces << space
        end
        
        return spaces
        
    end

    def find(id)
        sql = 'SELECT * FROM spaces WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)[0]
        space = Space.new
        space.id = result_set['id']
        space.name = result_set['name']
        space.description = result_set['description']
        space.price_per_night = result_set['price_per_night']
        space.owner_id = result_set['owner_id']

        return space
    end

    def create(space)
        sql = 'INSERT INTO spaces (name, description, price_per_night, owner_id) VALUES ($1,$2,$3,$4);'
        result_set = DatabaseConnection.exec_params(sql, [space.name, space.description, space.price_per_night, space.owner_id])

        return nil
    end
    
    def delete(id)

        # sql = 'SELECT id, name, description, price_per_night, owner_id FROM spaces WHERE id = $1;'
        # params = [id]
        result_set1 = find(id)
        
        sql = 'DELETE FROM spaces WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)

        return result_set1
    end
end