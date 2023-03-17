class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, id: :uuid do |t|
      t.integer :position
      t.boolean :winner, default: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :game, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
