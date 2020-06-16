class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :user, null: false, foreign_key: true, default: 1
      t.string :course_title, null: false, limit: 100
      t.text :course_overview, null: false
      t.text :course_description, null: false
      t.integer :course_type, null: false, inclusion: Settings.course_type.general.to_h.values, default: 1
      t.string :course_image
      t.string :overview_video_url

      t.timestamps
    end
  end
end
