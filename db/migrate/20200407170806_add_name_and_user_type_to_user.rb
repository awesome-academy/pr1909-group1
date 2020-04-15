class AddNameAndUserTypeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false, limit: 15
    add_column :users, :last_name, :string, null: false, limit: 15
    add_column :users, :user_type, :integer, null: false, inclusion: [1, 2, 3]
  end
end
