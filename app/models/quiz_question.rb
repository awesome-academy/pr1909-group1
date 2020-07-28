class QuizQuestion < ApplicationRecord
  belongs_to :lesson
  store_accessor :quiz_choice, :required, :attributes
  validate :must_has_answer

  def must_has_answer
    has_answer = 0
    quiz_choice.each do |quiz|
      if quiz.last["is_answer"] == "1"
        has_answer = 1
        break
      end
    end
    if has_answer == 0
      errors.add(:quiz_choice, "Question must be have at least a correct answer")
    end
  end
end
