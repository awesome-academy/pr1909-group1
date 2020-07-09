class QuizResult < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :user_id, :mark, presence: true, numericality:
  {
    only_integer: true, greater_than_or_equal_to: Settings.mark.min,
  }
  validates :user_id, uniqueness: { scope: :lesson_id }
end
