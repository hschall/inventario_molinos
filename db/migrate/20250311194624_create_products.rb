class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.integer :product_id
      t.string :product_name
      t.string :product_description
      t.integer :barcode

      t.timestamps
    end
  end
end
