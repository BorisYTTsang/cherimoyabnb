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
    sql = 'INSERT INTO bookings (space_id, unavailable_from, unavailable_to, reason, booker_id) VALUES ($1, $2, $3, $4, $5);'
    params = [booking.space_id, booking.unavailable_from, booking.unavailable_to, booking.reason, booking.booker_id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def overlaps_existing_booking?(new_booking)
    existing_bookings = find_by_space(new_booking.space_id)

    existing_bookings.each do |existing_booking|
      return true if check_for_overlap(existing_booking, new_booking)
    end

    return false
  end

  ''

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

  def check_for_overlap(existing_booking, new_booking)
    t1_from = existing_booking.unavailable_from
    t1_to = existing_booking.unavailable_to
    t2_from = new_booking.unavailable_from
    t2_to = new_booking.unavailable_to
    if  t1_from >= t2_from && t1_from <= t2_to #If 'from' date is inside of the existing booking range
      return true
    elsif t1_to >= t2_from && t1_to <= t2_to #If 'to' date is inside of the existing booking range
      return true
    elsif t1_from <= t2_from && t1_to >= t2_to #If the booking is longer than the existing booking and completely overlaps it
      return true
    elsif t1_from >= t2_from && t1_to <= t2_to #If the booking is shorter than the existing booking and would exist completely within it
      return true
    else
      return false
    end
  end
end