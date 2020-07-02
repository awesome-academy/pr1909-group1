class Lesson < ApplicationRecord
  belongs_to :course
  has_many :comment_lessons, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  validates :lesson_type, :lesson_sequence, :lesson_name, presence: true
  validates :lesson_name, length: { maximum: Settings.length.lesson_name.maximum }
  validates :course_id, uniqueness: { scope: :lesson_sequence }
  accepts_nested_attributes_for :quiz_questions, reject_if: :all_blank
end
