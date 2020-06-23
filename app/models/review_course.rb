class ReviewCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user_id, :course_id, presence: true, numericality: { only_integer: true }
  validates :comment, presence: true
end
