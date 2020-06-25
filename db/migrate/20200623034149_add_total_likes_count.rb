class AddTotalLikesCount < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :total_likes_count, :integer, default: 0
  end
end
