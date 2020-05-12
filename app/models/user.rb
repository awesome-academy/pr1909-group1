class User < ApplicationRecord
  has_one :candidate, dependent: :destroy
  has_one :employer, dependent: :destroy
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  enum user_type: Settings.u_type.general.to_h

  # Validates
  validates :first_name, presence: true, length: { maximum: 20 }, format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :last_name, presence: true, length: { maximum: 15 }, format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :user_type, presence: true, inclusion: { in: user_types.keys }
end
