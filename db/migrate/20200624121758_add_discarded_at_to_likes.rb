class AddDiscardedAtToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :discarded_at, :datetime
    add_index :likes, :discarded_at
  end
end
