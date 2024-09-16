class User < ApplicationRecord
  after_create :assign_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def admin?
    return role == ADMIN
  end
  private
  def assign_role
     self.update(role: USER)
  end
end
