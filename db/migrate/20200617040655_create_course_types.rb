class CreateCourseTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :course_types do |t|
      t.string :course_type, null: false, limit: Settings.length.course_type.maximum

      t.timestamps
    end
  end
end
