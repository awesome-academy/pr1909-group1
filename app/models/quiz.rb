class Quiz < ApplicationRecord
  has_many :quiz_results
  has_many :lessons, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  validates :quiz_name, length: { maximum: Settings.length.quiz_name.maximum }
end
