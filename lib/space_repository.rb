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
        result_set = DatabaseConnection.exec_params(sql, params)
        
        spaces = create_space_object_from_table(result_set)

        return spaces[0]
    end

    def create(space)
        sql = 'INSERT INTO spaces (name, description, price_per_night, owner_id) VALUES ($1,$2,$3,$4);'
        result_set = DatabaseConnection.exec_params(sql, [space.name, space.description, space.price_per_night, space.owner_id])

        return nil
    end
    
    def delete(id)

        # find record to be deleted first so it can be returned
        result_set1 = find(id) 
        
        sql = 'DELETE FROM spaces WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)

        return result_set1
    end

    private

    def create_space_object_from_table(result)
        spaces = []
        result.each do |record|
            space = Space.new
            space.id = record['id']
            space.name = record['name']
            space.description = record['description']
            space.price_per_night = record['price_per_night']
            space.owner_id = record['owner_id']
            spaces << space
        end
        return spaces
      end
end
