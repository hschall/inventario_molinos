class CreateWarehouses < ActiveRecord::Migration[7.1]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :address
      t.string :cp

      t.timestamps
    end
  end
end
