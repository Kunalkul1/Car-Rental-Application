class AddToStatusCar < ActiveRecord::Migration[5.0]
  def change
    change_column :cars, :status, :string, :default => 'Available'
  end
end
