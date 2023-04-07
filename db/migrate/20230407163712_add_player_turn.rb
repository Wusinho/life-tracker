class AddPlayerTurn < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :my_turn, :boolean, default: false
  end
end
