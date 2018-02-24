class AddDeletedAtToActsAsBookableBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :acts_as_bookable_bookings, :deleted_at, :datetime
    add_index :acts_as_bookable_bookings, :deleted_at
  end
end
