class PosInventory < ApplicationRecord
  belongs_to :po
  belongs_to :product

  validates :barcode, presence: true
  validates :qty, numericality: { greater_than_or_equal_to: 0 }
end
