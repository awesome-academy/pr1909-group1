class CreateEvaluateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluate_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :star

      t.timestamps
    end
  end
end
