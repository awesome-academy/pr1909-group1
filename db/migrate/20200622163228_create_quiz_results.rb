class CreateQuizResults < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_results do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :mark, null: false, inclusion: (Settings.mark.min..Settings.mark.max)

      t.timestamps
    end
  end
end
