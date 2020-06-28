class Lesson < ApplicationRecord
  belongs_to :course
  has_many :comment_lessons, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  # validates :course_id, :lesson_type, :lesson_sequence, presence: true, numericality: { only_integer: true }
  validates :lesson_name, length: { maximum: Settings.length.lesson_name.maximum }
  # validates :course_id, uniqueness: { scope: :lesson_sequence }
  accepts_nested_attributes_for :quiz_questions
end
