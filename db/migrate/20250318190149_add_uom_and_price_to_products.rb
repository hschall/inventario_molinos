class AddUomAndPriceToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :uom, :string
    add_column :products, :price, :decimal
  end
end
