require_relative './booking.rb'
require_relative './database_connection.rb'

class BookingRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT * FROM bookings;'
    result = DatabaseConnection.exec_params(sql,[])

    return create_booking_objects_from_table(result)
  end

  def find(id)
    sql = 'SELECT * FROM bookings WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    return create_booking_objects_from_table(result)[0]
  end

  def find_by_space(space_id)
    sql = 'SELECT * FROM bookings WHERE space_id = $1;'
    params = [space_id]
    result = DatabaseConnection.exec_params(sql, params)

    return create_booking_objects_from_table(result)
  end

  # Add more methods below for each operation you'd like to implement.

  def create(booking)
    # INSERT INTO bookings (name, email, password) VALUES ($1, $2, $3);
    # returns nothing
  end

  def check_for_overlap(booking)
    #Takes booking object as input
    #Checks for any overlap between the new booking and existing bookings
    #Returns true or false
  end

  # def update(booking)
  # end

  # def delete(booking)
  # end

  private
  def create_booking_objects_from_table(result)
    bookings = []
    result.each do |record|
      booking = Booking.new
      booking.id = record['id'].to_i
      booking.space_id = record['space_id'].to_i
      booking.unavailable_from = record['unavailable_from']
      booking.unavailable_to = record['unavailable_to']
      booking.reason = record['reason']
      booking.booker_id = record['booker_id'].to_i
      bookings << booking
    end
    return bookings
  end
end