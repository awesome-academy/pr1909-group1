class CreateApplyActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :apply_activities do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true
      t.bigint :employer_id,  null: false, index: true

      t.timestamps
    end
    add_foreign_key :apply_activities, :job_posts, column: :employer_id, to_table: { job_posts: :employer_id }
  end
end
