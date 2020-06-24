class CreateQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :quiz_question, null: false
      t.json :quiz_choice, null: false
      t.json :answer, null: false

      t.timestamps
    end
  end
end
