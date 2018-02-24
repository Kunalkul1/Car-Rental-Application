class AddRentalChargeToAddAsBookableBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :acts_as_bookable_bookings, :rental_charge, :decimal
  end
end
