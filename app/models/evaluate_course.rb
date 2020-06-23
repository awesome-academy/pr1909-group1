class EvaluateCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user_id, uniqueness: { scope: :course_id }
  validates :user_id, :course_id, presence: true, numericality: { only_integer: true }
end
