class QuizResult < ApplicationRecord
  belongs_to :quiz
  belongs_to :user
  validates :quiz_id, :user_id, :mark, presence: true, numericality:
  {
    only_integer: true, greater_than: Settings.mark.min, less_than: Settings.mark.max,
  }
end
