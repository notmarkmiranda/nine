class AddFinalizedToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :finalized, :boolean, default: false
  end
end
