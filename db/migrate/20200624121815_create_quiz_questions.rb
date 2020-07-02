class CreateQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_questions do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :quiz_question
      t.json :quiz_choice,
             {
               required: [:label, :text, :is_answer],
               attributes:
                {
                  label: { type: "string", default: "" },
                  text: { type: "string", default: "" },
                  is_answer: { type: "boolean", default: "false" },
                },
             }

      t.timestamps
    end
  end
end
