class PosInventoriesController < ApplicationController
  before_action :set_po, only: [:index, :create]

  # ✅ View POS inventory
  def index
    @inventory = @po.pos_inventories.order(added_at: :desc)
  end

  # ✅ Add product by scanning barcode
  def create
    barcode = params[:barcode]
    product = Product.find_by(barcode: barcode)

    if product
      @po.pos_inventories.create!(
        product_id: product.id,
        product_name: product.product_name,  # ✅ Use the correct column name
        product_description: product.product_description, # ✅ Match schema
        barcode: product.barcode,
        uom: product.uom,
        qty: 1,
        price: product.price,
        added_at: Time.current,
        added_by: "Manual Entry"
        )     
      redirect_to inventory_po_po_path(@po), notice: "Producto agregado correctamente."
    else
      redirect_to inventory_po_po_path(@po), alert: "Código de barras no encontrado."
    end
  end

  private

  def set_po
    @po = Po.find(params[:id]) # Ensure it's fetching by `id`
  end
end
