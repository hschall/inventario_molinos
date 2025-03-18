class CreateReceivedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :received_items do |t|
      t.references :shipment, null: false, foreign_key: true
      t.string :barcode
      t.integer :quantity

      t.timestamps
    end
  end
end
