class ShipmentItem < ApplicationRecord
  belongs_to :shipment
  belongs_to :product

  # Ensure quantity always has a default value
  before_save :set_default_quantity

  private

  def set_default_quantity
    self.quantity ||= 1
  end
end
