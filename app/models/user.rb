class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :outlines

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    roles.where(role_type: 0).size > 0
  end

  def instructor?
    roles.where(role_type: 1).size > 0
  end

  def guest?
    false
  end
end
