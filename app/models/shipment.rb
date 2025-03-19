class Shipment < ApplicationRecord
  belongs_to :from_warehouse, class_name: 'Warehouse'
  belongs_to :po
  has_many :shipment_items, dependent: :destroy
  has_many :received_items, dependent: :destroy
  has_many :products, through: :shipment_items

  validates :shipment_number, uniqueness: true

  before_create :generate_shipment_number
  before_update :update_status_timestamp, if: :status_changed?

      def has_discrepancies?
  shipment_items.reload.any? do |item| # ✅ Forces reloading
    expected_count = item.quantity || 0
    received_count = received_items.where(barcode: item.barcode).sum(:quantity) || 0
    expected_count != received_count
  end
end



  private

  def generate_shipment_number
    self.shipment_number = "SHP#{Time.now.to_i}"
  end

  def set_initial_status_timestamp
    self.status_updated_at = Time.current.in_time_zone("America/Mexico_City") # Replace with your timezone
  end

  def update_status_timestamp
    self.status_updated_at = Time.current.in_time_zone("America/Mexico_City") # Replace with your timezone
  end

end
