class AddTotalRegistersCountToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :total_registers_count, :integer, default: 0
  end
end
