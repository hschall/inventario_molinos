class CreateShipmentItems < ActiveRecord::Migration[7.1]
  def change
    create_table :shipment_items do |t|
      t.references :shipment, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :barcode

      t.timestamps
    end
  end
end
