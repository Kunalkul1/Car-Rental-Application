module UsersHelper

  def super_admin_true
    User.where(super_admin: true)
  end

end
