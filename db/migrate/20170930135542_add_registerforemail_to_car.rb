class AddRegisterforemailToCar < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :register_email, :boolean
  end
end
