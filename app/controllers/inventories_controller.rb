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
        flash[:notice] = "Product added to inventory successfully."
      else
        flash[:alert] = "Failed to add product to inventory."
      end
    else
      flash[:alert] = "No product found with this barcode."
    end
    
    redirect_to inventories_path
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    flash[:notice] = "Inventory item removed successfully."
    redirect_to inventories_path
  end
end