class CreateRegisters < ActiveRecord::Migration[6.0]
  def change
    create_table :registers do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :lesson_step, null: false, default: Settings.lesson_step.default

      t.timestamps
      t.index [:course_id, :user_id], unique: true
    end
  end
end
