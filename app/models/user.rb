class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :outlines
  has_many :elements, through: :outlines

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    role_types.include?('admin')
  end

  def instructor?
    role_types.include?('instructor')
  end

  def guest?
    false
  end

  def role_types
    roles.collect { |x| x.role_type }
  end
end
