class User < ActiveRecord::Base
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :outlines

  def name
    "#{first_name} #{last_name}"
  end
end
