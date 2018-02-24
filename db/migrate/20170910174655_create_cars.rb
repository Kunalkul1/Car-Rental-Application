class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :license_plate
      t.string :manufacturer
      t.string :model
      t.decimal :hourly_rental_rate
      t.string :style
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
