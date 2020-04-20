class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.string :company_logo
      t.string :company_name, limit: 70
      t.string :company_size, limit: 20
      t.text :company_description

      t.timestamps
    end
  end
end
