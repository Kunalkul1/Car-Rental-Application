class AddUserToCar < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :user, :string
  end
end
