class QuizQuestion < ApplicationRecord
  belongs_to :quiz
  validates :quiz_id, :quiz_question, :quiz_choice, :answer, presence: true
  validates :quiz_id, numericality: { only_integer: true }
end
