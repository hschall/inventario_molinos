class AddQuantityToShipmentItems < ActiveRecord::Migration[7.1]
  def change
    add_column :shipment_items, :quantity, :integer
  end
end
