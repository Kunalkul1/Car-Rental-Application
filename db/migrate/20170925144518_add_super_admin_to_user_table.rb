class AddSuperAdminToUserTable < ActiveRecord::Migration[5.0]
  def change
    User.create(email: "superadmin@carrental.com", password: "superadmin", admin: true, super_admin: true, name: "Super admin")
  end
end
