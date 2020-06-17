class Register < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :course_id, :user_id, presence: true, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: :course_id }
end
