class User < ApplicationRecord
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
     
       validates :admin, inclusion: { in: [true, false] }
     
       def admin?
         admin # Make sure this returns `true` for admins
       end
     end