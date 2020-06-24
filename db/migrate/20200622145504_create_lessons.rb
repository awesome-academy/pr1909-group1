class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.references :quiz, foreign_key: true
      t.string :lesson_name, null: false
      t.integer :lesson_sequence, null: false
      t.string :video_url

      t.timestamps
    end
  end
end
