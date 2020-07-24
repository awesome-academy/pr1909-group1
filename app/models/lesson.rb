class Lesson < ApplicationRecord
  belongs_to :course
  has_many :comment_lessons, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  validates :lesson_type, :lesson_sequence, :lesson_name, presence: true
  validates :lesson_name, length: { maximum: Settings.length.lesson_name.maximum }
  validates :min_point, numericality: { only_integer: true, greater_than_or_equal_to: Settings.mark.min },
                        presence: true, if: Proc.new { |lesson| lesson.quiz? }
  validates :video_url, presence: true, if: Proc.new { |lesson| lesson.video? }
  enum lesson_type: Settings.lesson_type.to_h
  accepts_nested_attributes_for :quiz_questions,
                                reject_if: proc { |attribute| attribute["quiz_question"].blank? }, allow_destroy: true
end
