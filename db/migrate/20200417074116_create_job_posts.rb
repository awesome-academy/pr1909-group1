class CreateJobPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :job_posts do |t|
      t.references :employer, null: false, foreign_key: true
      t.integer :job_location, null: false, inclusion: Settings.job_location.general.to_h.values
      t.integer :job_type, null: false, inclusion: Settings.job_type.general.to_h.values
      t.integer :job_status, null: false, default: 1, inclusion: Settings.job_status.general.to_h.values
      t.integer :post_priority, null: false, default: 5
      t.integer :salary_min, null: false, default: 0
      t.integer :salary_max, default: 1
      t.string :post_title, null: false, limit: 100
      t.text :job_description, null: false
      t.date :job_expired_date, null: false

      t.timestamps
    end
  end
end
