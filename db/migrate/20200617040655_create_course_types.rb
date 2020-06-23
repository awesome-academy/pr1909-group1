class CreateCourseTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :course_types do |t|
      t.string :course_type, null: false, limit: 50

      t.timestamps
    end
  end
end
