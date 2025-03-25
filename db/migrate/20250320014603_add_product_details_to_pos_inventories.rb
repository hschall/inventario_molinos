class AddProductDetailsToPosInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :pos_inventories, :product_name, :string
    add_column :pos_inventories, :product_description, :string
    add_column :pos_inventories, :barcode, :integer
    add_column :pos_inventories, :uom, :string
    add_column :pos_inventories, :qty, :integer
    add_column :pos_inventories, :price, :decimal
    add_column :pos_inventories, :added_at, :datetime unless column_exists?(:pos_inventories, :added_at)
    add_column :pos_inventories, :added_by, :string
  end
end
