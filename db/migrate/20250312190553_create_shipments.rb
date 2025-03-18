class CreateShipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shipments do |t|
      t.references :from_warehouse, foreign_key: { to_table: :warehouses }
      t.references :po, foreign_key: true
      t.string :shipment_number
      t.string :status

      t.timestamps
    end
  end
end
