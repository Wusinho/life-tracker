class CreateUserKills < ActiveRecord::Migration[7.0]
  def change
    create_table :user_kills, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :deceased_id, null: false

      t.timestamps
    end
  end
end
