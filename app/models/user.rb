class User < ApplicationRecord
  has_one :candidate, dependent: :destroy
  has_one :employer, dependent: :destroy
  acts_as_paranoid
  attr_readonly :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  enum user_type: Settings.u_type.general.to_h

  # Validates
  validates :first_name, presence: true, length: { maximum: Settings.max_length.first_name },
                         format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :last_name, presence: true, length: { maximum: Settings.max_length.last_name },
                        format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :user_type, presence: true, inclusion: { in: user_types.keys }
  validates :email, format: { with: /\A([a-zA-Z0-9_\.])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+\z/ }
end
