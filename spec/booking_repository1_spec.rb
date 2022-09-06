require 'booking_repository'

def reset_bookings_table
    seed_sql = File.read('spec/seeds/bookings_seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
    connection.exec(seed_sql)
end
  
RSpec.describe BookingRepository do
    before(:each) do 
      reset_bookings_table
    end

    describe '# GET' do
        it 'gets all bookings' do
          repo = BookingRepository.new
          bookings = repo.all

          expect(bookings.length).to eq 5

          expect(bookings[0].id).to eq 1
          expect(bookings[0].space_id).to eq 1
          expect(bookings[0].unavailable_from).to eq '2022-09-10'
          expect(bookings[0].unavailable_to).to eq '2022-09-20'
          expect(bookings[0].reason).to eq 'booking'
          expect(bookings[0].booker_id).to eq 1


          expect(bookings[1].id).to eq 2
          expect(bookings[1].space_id).to eq 3
          expect(bookings[1].unavailable_from).to eq '2022-10-10'
          expect(bookings[1].unavailable_to).to eq '2022-10-14'
          expect(bookings[1].reason).to eq 'booking'
          expect(bookings[1].booker_id).to eq 3

          expect(bookings.last.id).to eq 5
          expect(bookings.last.space_id).to eq 1
          expect(bookings.last.unavailable_from).to eq '2022-09-22'
          expect(bookings.last.unavailable_to).to eq '2022-09-25'
          expect(bookings.last.reason).to eq 'booking'
          expect(bookings.last.booker_id).to eq 6
        end
    end


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
end
