class AddAasmStateToApplyActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :apply_activities, :aasm_state, :string
    add_column :apply_activities, :test_marks, :integer, null: false, default: 0, inclusion: 0..9
  end
end
