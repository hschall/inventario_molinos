json.extract! product, :id, :product_id, :product_name, :product_description, :barcode, :created_at, :updated_at
json.url product_url(product, format: :json)
