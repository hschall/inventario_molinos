# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_19_183205) do
  create_table "inventories", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "barcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_inventories_on_product_id"
  end

  create_table "pos", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "cp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ruta"
  end

  create_table "products", force: :cascade do |t|
    t.integer "product_id"
    t.string "product_name"
    t.string "product_description"
    t.integer "barcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uom"
    t.decimal "price"
  end

  create_table "received_items", force: :cascade do |t|
    t.integer "shipment_id", null: false
    t.string "barcode"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipment_id"], name: "index_received_items_on_shipment_id"
  end

  create_table "shipment_items", force: :cascade do |t|
    t.integer "shipment_id", null: false
    t.integer "product_id", null: false
    t.string "barcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["product_id"], name: "index_shipment_items_on_product_id"
    t.index ["shipment_id"], name: "index_shipment_items_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "from_warehouse_id"
    t.integer "po_id"
    t.string "shipment_number"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_discrepancies"
    t.datetime "status_updated_at"
    t.index ["from_warehouse_id"], name: "index_shipments_on_from_warehouse_id"
    t.index ["po_id"], name: "index_shipments_on_po_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "cp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inventories", "products"
  add_foreign_key "received_items", "shipments"
  add_foreign_key "shipment_items", "products"
  add_foreign_key "shipment_items", "shipments"
  add_foreign_key "shipments", "pos"
  add_foreign_key "shipments", "warehouses", column: "from_warehouse_id"
end
