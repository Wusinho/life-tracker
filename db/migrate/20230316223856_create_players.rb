class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, id: :uuid do |t|
      t.integer :position
      t.integer :damage_done, default: 0
      t.boolean :winner, default: false
      t.integer :lives, default: 20
      t.boolean :active, default: true
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :game, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
