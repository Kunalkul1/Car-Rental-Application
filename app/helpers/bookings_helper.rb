module BookingsHelper

  def calculate_rental_charge
    unless current_user.admin? && current_user.super_admin?
      @booked_car_records = Booking.with_deleted.find_by_booker_id(current_user.id)
      unless @booked_car_records.nil?
        @booked_car = @booked_car_records.bookable_id
        @hourly_rate = Car.find(@booked_car).hourly_rental_rate
        @time_diff = ((Booking.with_deleted.find_by_booker_id(current_user.id).time_end - Booking.with_deleted.find_by_booker_id(current_user.id).time_start) / 3600).round
        @rental_charge = @hourly_rate * @time_diff
      end
    end
  end

  def license_plate(t)
    Car.where(:id => t.bookable_id).first.license_plate
  end

  def model(t)
    Car.where(:id => t.bookable_id).first.model
  end

  def manufacturer(t)
    Car.where(:id => t.bookable_id).first.manufacturer
  end

  def booking
    @booking = Booking.find_by_bookable_id(params[:id])
  end

  def find_user_name(t)
    User.find(t.booker_id).name
  end

  def find_user_email
    @user_email = User.find_by_id(booking.booker_id).email
  end

  def start_time
    @start_time = booking.time_start
  end

  def end_time
    @end_time = booking.time_end
  end

  def normal_users
    User.where(:admin => false, :super_admin => false).collect(&:email)
  end

end
