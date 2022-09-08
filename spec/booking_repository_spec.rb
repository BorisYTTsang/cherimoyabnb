require 'booking_repository'

def reset_all
  userseed_sql = File.read('spec/seeds/users_seed.sql')
  spaceseed_sql = File.read('spec/seeds/spaces_seed.sql')
  requestseed_sql = File.read('spec/seeds/requests_seed.sql')
  bookingseed_sql = File.read('spec/seeds/bookings_seed.sql')

  connection = PG.connect({ host: '127.0.0.1', dbname: 'cherimoyabnb_test' })
  connection.exec(userseed_sql)
  connection.exec(spaceseed_sql)
  connection.exec(requestseed_sql)
  connection.exec(bookingseed_sql)
end

RSpec.describe BookingRepository do

    before(:each) do 
      reset_all
    end

    describe '#GET' do
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
    describe '#find' do
        it 'finds and returns a single booking' do
            repo = BookingRepository.new

            booking = repo.find(1)

            expect(booking.id).to eq 1
            expect(booking.space_id).to eq 1
            expect(booking.unavailable_from).to eq '2022-09-10'
            expect(booking.unavailable_to).to eq '2022-09-20'
            expect(booking.reason).to eq 'booking'
            expect(booking.booker_id).to eq 1
        end
    end
    describe '#find_by_space' do
      it 'finds and returns one bookings matching the space_id 3' do
          repo = BookingRepository.new

          bookings = repo.find_by_space(3)

          expect(bookings[0].id).to eq 2
          expect(bookings[0].space_id).to eq 3
          expect(bookings[0].unavailable_from).to eq '2022-10-10'
          expect(bookings[0].unavailable_to).to eq '2022-10-14'
          expect(bookings[0].reason).to eq 'booking'
          expect(bookings[0].booker_id).to eq 3
      end
      it 'finds and returns two bookings matching the space_id 1' do
        repo = BookingRepository.new

        bookings = repo.find_by_space(1)

        expect(bookings.length).to eq 2

        expect(bookings[0].id).to eq 1
        expect(bookings[0].space_id).to eq 1
        expect(bookings[0].unavailable_from).to eq '2022-09-10'
        expect(bookings[0].unavailable_to).to eq '2022-09-20'
        expect(bookings[0].reason).to eq 'booking'
        expect(bookings[0].booker_id).to eq 1

        expect(bookings[1].booker_id).to eq 6
    end
  end
  context 'Creating a new booking'
    describe '#create' do
      it 'creates a new booking' do
        repo = BookingRepository.new

        new_booking = Booking.new

        new_booking.space_id = 1
        new_booking.unavailable_from = '2023-04-22'
        new_booking.unavailable_to = '2023-09-22'
        new_booking.reason = 'booking'
        new_booking.booker_id = 3


        repo.create(new_booking)

        all_bookings = repo.all
        booking = all_bookings[-1]
        expect(booking.space_id).to eq 1
        expect(booking.unavailable_from).to eq '2023-04-22'
        expect(booking.unavailable_to).to eq '2023-09-22'
        expect(booking.reason).to eq 'booking'
        expect(booking.booker_id).to eq 3
        expect(repo.create(new_booking)).to eq false
      end
      it 'does not create a booking if the space does not exist' do
        repo = BookingRepository.new

        new_booking = Booking.new

        new_booking.space_id = 15
        new_booking.unavailable_from = '2023-04-22'
        new_booking.unavailable_to = '2023-09-22'
        new_booking.reason = 'booking'
        new_booking.booker_id = 3


        repo.create(new_booking)

        all_bookings = repo.all
        booking = all_bookings[-1]
        expect(booking.space_id).to eq 1
        expect(booking.unavailable_from).to eq '2022-09-22'
        expect(booking.unavailable_to).to eq '2022-09-25'
        expect(booking.reason).to eq 'booking'
        expect(booking.booker_id).to eq 6
    end
    describe '#overlaps_existing_booking?' do
      it 'returns true if a new booking date overlaps the unavailable_to for an existing booking' do
        repo = BookingRepository.new

        new_booking = Booking.new

        new_booking.space_id = 1
        new_booking.unavailable_from = '2022-09-19'
        new_booking.unavailable_to = '2022-09-22'
        new_booking.reason = 'booking'
        new_booking.booker_id = 1

        expect(repo.send(:overlaps_existing_booking?, new_booking)).to eq true
      end
      it 'returns true if a new booking date overlaps the unavailable_from for an existing booking' do
        repo = BookingRepository.new

        new_booking = Booking.new

        new_booking.space_id = 1
        new_booking.unavailable_from = '2022-09-06'
        new_booking.unavailable_to = '2022-09-11'
        new_booking.reason = 'booking'
        new_booking.booker_id = 1

        expect(repo.send(:overlaps_existing_booking?, new_booking)).to eq true
      end
      it 'returns true if a new booking date unavailable_from equals unavailable_to for an existing booking' do
        repo = BookingRepository.new

        new_booking = Booking.new

        new_booking.space_id = 1
        new_booking.unavailable_from = '2022-09-20'
        new_booking.unavailable_to = '2022-09-22'
        new_booking.reason = 'booking'
        new_booking.booker_id = 1

        expect(repo.send(:overlaps_existing_booking?, new_booking)).to eq true
      end
      it 'returns false if no overlap' do
        repo = BookingRepository.new

        new_booking = Booking.new

        new_booking.space_id = 1
        new_booking.unavailable_from = '2022-09-27'
        new_booking.unavailable_to = '2022-09-28'
        new_booking.reason = 'booking'
        new_booking.booker_id = 1

        expect(repo.send(:overlaps_existing_booking?, new_booking)).to eq false
      end
    end
  end
end
