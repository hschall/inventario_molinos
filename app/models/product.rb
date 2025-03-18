class Product < ApplicationRecord
  has_many :inventories
  has_many :shipment_items
  has_many :shipments, through: :shipment_items
  validates :barcode, uniqueness: true
end
