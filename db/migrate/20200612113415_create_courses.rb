class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :course_title, null: false, limit: 100
      t.text :course_overview, null: false
      t.text :course_description, null: false
      t.integer :course_type, null: false, inclusion: Settings.course_type.general.to_h.values
      t.string :course_image
      t.string :overview_video_url

      t.timestamps
    end
  end
end
