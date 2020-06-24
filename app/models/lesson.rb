class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :quiz
  has_many :comment_lessons, dependent: :destroy

  validates :course_id, :quiz_id, presence: true, numericality: { only_integer: true }
  validates :lesson_name, length: { maximum: Settings.length.lesson_name.maximum }
  validates :course_id, uniqueness: { scope: :lesson_sequence }
end
