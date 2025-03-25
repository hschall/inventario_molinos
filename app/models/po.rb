class Po < ApplicationRecord
  has_many :shipments, foreign_key: 'po_id'
  has_many :pos_inventories, dependent: :destroy
end
