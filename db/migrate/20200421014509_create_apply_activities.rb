class CreateApplyActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :apply_activities do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true
      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
