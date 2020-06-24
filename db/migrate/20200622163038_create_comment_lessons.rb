class CreateCommentLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_lessons do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
