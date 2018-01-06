class CreateGame < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.references :season, foreign_key: true
      t.integer :attendees
      t.integer :buy_in
      t.references :user, foreign_key: true
      t.boolean :privated, default: false
      t.timestamps null: false
    end
  end
end
