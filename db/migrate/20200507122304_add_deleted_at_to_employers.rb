class AddDeletedAtToEmployers < ActiveRecord::Migration[6.0]
  def change
    add_column :employers, :deleted_at, :datetime
    add_index :employers, :deleted_at
  end
end
