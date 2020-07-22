class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :course_title, null: false, limit: Settings.length.course_title.maximum
      t.string :course_overview, null: false, limit: Settings.length.course_overview.maximum
      t.text :course_description, null: false
      t.string :course_image
      t.string :overview_video_url

      t.timestamps
    end
  end
end
