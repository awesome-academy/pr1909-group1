class AddCourseTypeToCourse < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :course_type, null: false, foreign_key: true
  end
end
