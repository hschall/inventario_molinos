class AddAddedAtToPosInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :pos_inventories, :added_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
