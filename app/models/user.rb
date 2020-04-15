class User < ApplicationRecord
  has_one :candidate, dependent: :destroy
  has_one :employer, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  enum user_type: { candidate: 1, employer: 2, admin: 3 }

  # Validates

  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 15 }
  validates :user_type, presence: true, inclusion: { in: ["candidate", "employer", "admin"] }

end
