class AddProfessionAndWebsiteToCandidates < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :profession, :string
    add_column :candidates, :website, :string
  end
end
