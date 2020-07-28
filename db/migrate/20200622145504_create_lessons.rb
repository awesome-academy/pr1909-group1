class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.string :lesson_name, null: false
      t.integer :lesson_type, null: false, default: Settings.default.lesson_type
      t.integer :lesson_sequence, null: false, default: Settings.default.lesson_sequence
      t.string :video_url
      t.integer :min_point

      t.timestamps
    end
  end
end
