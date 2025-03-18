class Po < ApplicationRecord
  has_many :shipments, foreign_key: 'po_id'
end
