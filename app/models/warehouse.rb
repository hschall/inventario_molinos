class Warehouse < ApplicationRecord
  has_many :shipments, foreign_key: 'from_warehouse_id'
end
