class User < ApplicationRecord
  # Include default Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy

  # Define admin user by email
  def admin?
    self.email == "emrah.sekic@scv.si"
  end
end
