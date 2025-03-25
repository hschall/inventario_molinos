class CreatePosInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :pos_inventories do |t|
      t.references :po, null: false, foreign_key: true # ✅ Uses po_id instead of pos_id
      t.references :product, null: false, foreign_key: true
      t.string :barcode, null: false
      t.string :name, null: false
      t.text :description
      t.string :uom, null: false # Unit of Measure
      t.integer :qty, null: false, default: 1
      t.decimal :price, precision: 10, scale: 2, null: false
      t.datetime :added_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :source, null: false, default: "manual" # manual, scan, shipment
      t.timestamps
    end
  end
end
