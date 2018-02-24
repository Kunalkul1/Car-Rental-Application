class Booking < ApplicationRecord
  acts_as_paranoid
  self.table_name = "acts_as_bookable_bookings"

  def self.checking_status
    cars = Car.all
    cars.each do |car|
      unless Booking.find_by_bookable_id(car.id) == nil
        unless Booking.find_by_bookable_id(car.id).time_start == nil
          if car.status == "Reserved" and Time.now  > Booking.find_by_bookable_id(car).time_start + 30.minutes and Time.now < Booking.find_by_bookable_id(car).time_end
            Booking.where(:bookable_id => car.id , :booker_id => Booking.find_by_bookable_id(car).booker_id).last.destroy
            car.status = "Available"
            car.save!

          elsif car.status == "Checked out" and Time.now + 4.hours >= Booking.find_by_bookable_id(car).time_end
            booker_id = Booking.find_by_bookable_id(car).booker_id
            mailer = User.find_by_id(booker_id)
            ExampleMailer.sample_email(mailer).deliver
            Booking.where(:bookable_id => car.id , :booker_id => booker_id).last.destroy
            car.status = "Available"
            car.save!
          end
        end
      end
    end
  end
end
