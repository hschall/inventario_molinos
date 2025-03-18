class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.includes(:product).all
    @inventory = Inventory.new
  end

  def create
    barcode = params[:inventory][:barcode]
    product = Product.find_by(barcode: barcode)

    if product
      @inventory = Inventory.new(product: product, barcode: barcode)

      if @inventory.save
        flash[:notice] = "Producto agregado correctamente al inventario."
      else
        flash[:alert] = "No se pudo agregar el producto al inventario."
      end
    else
      flash[:alert] = "No se encontro ningun producto con ese Codigo de Barras."
    end
    
    redirect_to inventories_path
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    flash[:notice] = "Producto eliminado correctamente del inventario."
    redirect_to inventories_path
  end
end