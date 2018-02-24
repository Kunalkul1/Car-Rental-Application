module CarsHelper
  def instance_variables
    @booking = Booking.find_by_bookable_id(car.id)
  end

  def current_user_is_admin?
    current_user.admin?
  end

  def current_user_is_super_admin?
    current_user.super_admin?
  end

  def user_booking(current_user, car)
    Booking.where(:booker_id => current_user.id, :bookable_id => car.id)
  end

  def check_time(current_user, car)
    Time.now >= user_booking(current_user, car).last.time_start
  end
end
