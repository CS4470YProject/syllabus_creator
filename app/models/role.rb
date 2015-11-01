class Role < ActiveRecord::Base
  has_many :user_roles

  enum role_type: %w(admin instructor)

  def admin?
    role_type == 'admin'
  end

  def instructor?
    role_type == 'instructor'
  end
end
