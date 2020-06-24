class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :quiz_name, limit: Settings.length.quiz_name.maximum

      t.timestamps
    end
  end
end
