class AddScheduleToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :schedule, :text
  end
end
