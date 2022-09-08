require_relative './request'
require_relative './database_connection'

class RequestRepository
    def all
        requests = []
        sql = 'SELECT * FROM requests;'
        result_set = DatabaseConnection.exec_params(sql, [])

        result_set.each do |record|
            request = Request.new
            request.id = record['id'].to_i
            request.space_id = record['space_id']
            request.owner_id = record['owner_id']
            request.booker_id = record['booker_id']
            request.booked = record['booked']
            request.date_from = record['date_from']
            request.date_to = record['date_to']

            requests << request
        end
        
        return requests
    end 

    def find(id)
        sql = 'SELECT * FROM requests WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)
        
        requests = create_request_object_from_table(result_set)

        return requests[0]
    end

    def find_requests_by_booker_id(booker_id)
        sql = 'SELECT * FROM requests WHERE booker_id = $1;'
        params = [booker_id]
        result_set = DatabaseConnection.exec_params(sql, params)
        
        requests = create_request_object_from_table(result_set)

        return requests
    end

    def find_requests_by_owner_id(owner_id)
        sql = 'SELECT * FROM requests WHERE owner_id = $1;'
        params = [owner_id]
        result_set = DatabaseConnection.exec_params(sql, params)
        
        requests = create_request_object_from_table(result_set)

        return requests
    end

    def create(request)
        sql = 'INSERT INTO requests (space_id, owner_id, booker_id, booked, date_from, date_to) VALUES ($1,$2,$3,$4,$5,$6);'
        result_set = DatabaseConnection.exec_params(sql, [request.space_id, request.owner_id, request.booker_id, request.booked, request.date_from, request.date_to])

        return nil
    end

    def create_request_object_from_table(result)
        requests = []
        result.each do |record|
          request = Request.new
          request.id = record['id'].to_i
          request.space_id = record['space_id']
          request.owner_id = record['owner_id']
          request.booker_id = record['booker_id']
          request.booked = record['booked']
          request.date_from = record['date_from']
          request.date_to = record['date_to']
          requests << request
        end
        return requests
      end
end