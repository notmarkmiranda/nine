class CreateSeason < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.boolean :active, default: true
      t.boolean :completed, default: false
      t.references :league, foreign_key: true

      t.timestamps null: false
    end
  end
end
