require 'booking'

class BookingRepository
    def all
        bookings = []
        sql = 'SELECT * FROM bookings;'
        result_set = DatabaseConnection.exec_params(sql, [])
        
        result_set.each do |record|
            booking = Booking.new
            bookings.id = record['id'].to_i
            bookings.space_id = record['space_id']
            bookings.unavailable_from = record['unavailable_from']
            bookings.unavailable_to = record['unavailable_to']
            bookings.reason = record['reason']
            bookings.booker_id = record['booker_id']

            bookings << booking
        end

        return bookings

    end


    def find ()
        sql = 'SELECT * FROM bookings WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)
        booking = Space.new
        booking.id = result_set.id
        booking.space_id = result_set.space_id
        booking.unavailable_from = result_set.unavailable_from
        booking.unavailable_to = result_set.unavailable_to
        booking.reason = result_set.reason
        booking.booker_id = result_set.booker_id

        return booking
    end


    def create(booking)
        sql = 'INSERT INTO bookings (space_id, unavailable_from, unavailable_to, reason, booker_id) VALUES ($1,$2,$3,$4,$5);'
        result_set = DatabaseConnection.exec_params(sql, [booking.space_id, booking.unavailable_from, booking.unavailable_to, booking.reason, booking.booker_id])

        return nil
    end

    def last
    end
end