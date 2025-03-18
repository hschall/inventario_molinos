class AddHasDiscrepanciesToShipments < ActiveRecord::Migration[7.1]
  def change
    add_column :shipments, :has_discrepancies, :boolean
  end
end
