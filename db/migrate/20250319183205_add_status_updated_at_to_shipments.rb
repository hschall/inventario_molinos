class AddStatusUpdatedAtToShipments < ActiveRecord::Migration[7.1]
  def change
    add_column :shipments, :status_updated_at, :datetime
  end
end
