class EvaluateCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user_id, uniqueness: { scope: :course_id }
  validates :user_id, :course_id, :star, presence: true, numericality: { only_integer: true }
  validates :star, inclusion: { in: (Settings.star.min..Settings.star.max) }
end
