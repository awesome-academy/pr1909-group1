class QuizQuestion < ApplicationRecord
  belongs_to :lesson
  store_accessor :quiz_choice, :required, :attributes
end
