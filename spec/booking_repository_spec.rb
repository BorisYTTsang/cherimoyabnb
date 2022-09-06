# require 'booking_repository'

# def reset_bookings_table
#     seed_sql = File.read('spec/seeds_bookings.sql')
#     connection = PG.connect({ host: '127.0.0.1', dbname: 'bookings' })
#     connection.exec(seed_sql)
# end
  
# RSpec.describe BookingRepository do
#     before(:each) do 
#       reset_bookings_table
#     end

#     describe '# GET' do
#         it 'gets all bookings' do

#             repo = bookingRepository.new

#             bookings = repo.all

#             bookings.length # =>  2

#             (bookings[0].id).to eq 1
#             (bookings[0].space_id).to eq 'David'
#             (bookings[0].unavailable_from).to eq 'April 2022'
#             (bookings[0].unavailable_to).to eq 'April 2022'
#             (bookings[0].reason).to eq 'April 2022'
#             (bookings[0].owner_id).to eq 'April 2022'

#             (bookings[1].id).to eq 2
#             (bookings[1].space_id).to eq 'Anna'
#             (bookings[1].unavailable_from).to eq 'May 2022'
#             (bookings[1].unavailable_to).to eq 'May 2022'
#             (bookings[1].reason).to eq 'May 2022'
#             (bookings[1].owner_id).to eq 'May 2022'
#         end
#     end


#     # 2
#     # Get a single booking
#     describe '#find' do
#         it 'finds and returns a single booking' do
#             repo = bookingRepository.new

#             booking = repo.find(1)

#             (booking.id).to eq 1
#             (booking.namspace_id).to eq 'David'
#             (booking.unavailable_from).to eq 'April 2022'
#             (booking.unavailable_to).to eq 'April 2022'
#             (booking.reason).to eq 'April 2022'
#             (booking.owner_id).to eq 'April 2022'
#         end
#     end

#     describe '#create' do
#         it 'creates a new booking' do
#         repo = BookingRepository.new

#         new_booking = Booking.new

#         new_booking.name # => 'John'
#         new_booking.space_id # => 'York'
#         new_booking.unavailable_from # => '12/09/2022'
#         new_booking.unavailable_to # => '26/09/2022'
#         new_booking.reason # => 'Rented out'
#         new_booking.space_id # => '3'


#         repo.create(new_booking)

#         booking = repo.all.last

#         expect(booking.name).to eq 'John'
#         expect(booking.space_id).to eq 'York'
#         expect(booking.unavailable_from).to eq '12/09/2022'
#         expect(booking.unavailable_to).to eq '26/09/2022'
#         expect(booking.reason).to eq 'Rented out'
#         expect(booking.owner_id).to eq '3'
#         end
#     end
# end
