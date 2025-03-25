class Product < ApplicationRecord
  has_many :inventories
  has_many :shipment_items
  has_many :shipments, through: :shipment_items
  has_many :pos_inventories, dependent: :destroy
  validates :barcode, uniqueness: true
end
