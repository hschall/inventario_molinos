class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :add_item, :remove_item, :submit_shipment, :receive_shipment, :complete_shipment]


  def index
    @shipments = Shipment.all
  end

  def show
  @shipment = Shipment.find_by(id: params[:id])
  
  if @shipment.nil?
    flash[:error] = "Shipment not found!"
    redirect_to shipments_path
  end
end

  def new
    @shipment = Shipment.new
    @warehouses = Warehouse.all
    @pos = Po.all
  end

  def create
  # Ensure that both warehouse and POS are selected
  if params[:shipment][:from_warehouse_id].blank? || params[:shipment][:po_id].blank?
    flash[:alert] = "Both Warehouse and POS must be selected to create a shipment."
    return redirect_to new_shipment_path
  end

  @shipment = Shipment.new(
    from_warehouse_id: params[:shipment][:from_warehouse_id],
    po_id: params[:shipment][:po_id],
    status: "Pending"
  )

  if @shipment.save
    flash[:notice] = "Envio creado correctamente!"
    redirect_to shipment_path(@shipment)
  else
    flash[:alert] = "No se pudo crear el Envio."
    render :new
  end
end


  def destroy
    @shipment = Shipment.find_by(id: params[:id])

    if @shipment
      @shipment.destroy # This will remove the shipment and its related shipment_items
      flash[:success] = "Envio eliminado correctamente!."
    else
      flash[:error] = "No se encontro el envio!"
    end

    redirect_to shipments_path
  end

  def add_item
  if @shipment.status != "Pending"
    flash[:alert] = "No se puede modificar este Envio porque ya esta En Ruta."
    return redirect_to shipment_path(@shipment)
  end

  barcode = params[:barcode].strip
  product = Product.find_by(barcode: barcode)

  if product
    item = @shipment.shipment_items.find_or_initialize_by(product: product, barcode: barcode)
    item.quantity ||= 0
    item.quantity += 1
    item.save!

    flash[:success] = "El Producto #{product.product_name} ha sido agregado al Envio."
  else
    flash[:error] = "Producto con Codigo de Barras #{barcode} no fue encontrado!"
  end

  redirect_to shipment_path(@shipment)
end



  def remove_item
  shipment_id = params[:shipment_id] || params[:id]  # Use either parameter
  @shipment = Shipment.find_by(id: shipment_id) # Find the shipment

  unless @shipment
    flash[:error] = "Envio no encontrado!"
    return redirect_to shipments_path
  end

  # Prevent removal if the shipment has been submitted
  if @shipment.status != "Pending"
    flash[:alert] = "No se pueden eliminar productos despues de mandar el envio."
    return redirect_to shipment_path(@shipment)
  end

  item = @shipment.shipment_items.find_by(id: params[:item_id]) # Find the item in the shipment

  if item
    item.destroy
    flash[:success] = "Producto eliminado con exito."
  else
    flash[:error] = "Producto no se encontro en el envio!"
  end

  redirect_to shipment_path(@shipment)
end


  def submit_shipment
  if @shipment.status == "Pending"
    @shipment.update(status: "In Transit")
    flash[:notice] = "Envio se encuentra en ruta."
  else
    flash[:alert] = "No se puede mandar este Envio."
  end
  redirect_to shipments_path
end

  def receive_shipment
  if @shipment.present? && @shipment.status == "In Transit"
    @shipment.update(status: "Arrived")

    respond_to do |format|
      format.html { redirect_to shipment_path(@shipment), notice: "Envio recibido correctamente!." } # ✅ Redirects back to shipment details
      format.turbo_stream # ✅ Turbo-stream to update status dynamically
    end
  else
    flash[:alert] = "No fue posible recibir el envio."
    redirect_to shipment_path(@shipment) # ✅ Stay on the same page
  end
end



def scan_received_item
  shipment_id = params[:shipment_id] || params[:id] # ✅ Ensure it fetches by shipment_id
  @shipment = Shipment.find_by(id: shipment_id)

  unless @shipment
    flash[:error] = "Envio no encontrado!"
    return redirect_to shipments_path
  end

  # Ensure the shipment is in "Arrived" state
  unless @shipment.status == "Arrived"
    flash[:alert] = "No se pueden escanear productos hasta que el envio haya sido recibido."
    return redirect_to shipment_path(@shipment)
  end

  barcode = params[:barcode].strip
  item = @shipment.shipment_items.find_by(barcode: barcode)

  if item
    received_item = @shipment.received_items.find_or_initialize_by(barcode: barcode)
    received_item.quantity ||= 0
    received_item.quantity += 1
    received_item.save

    flash[:success] = "Scanned item: #{barcode}. Total received: #{received_item.quantity}"
  else
    flash[:error] = "Codigo de barras no encontrado en el envio!"
  end

  redirect_to shipment_path(@shipment)
end


def complete_shipment
  if @shipment.status == "Arrived"
    discrepancies_exist = @shipment.has_discrepancies? # Ensure we detect discrepancies

    @shipment.update!(status: "Completed", has_discrepancies: discrepancies_exist) # Force save!

    respond_to do |format|
      format.html { redirect_to shipment_path(@shipment), notice: "Ha completado la recepcion del Envio!." }
      format.turbo_stream
    end
  else
    flash[:alert] = "Error al completar el envio."
    redirect_to shipment_path(@shipment)
  end
end





  

  def pos_shipments
  @po = Po.find(params[:id])  # Get the POS location
  @shipments = Shipment.where(po_id: @po.id) # Fetch shipments for this POS
end



  private

  def set_shipment
  shipment_id = params[:shipment_id] || params[:id]
  @shipment = Shipment.find_by(id: shipment_id)

  unless @shipment
    flash[:error] = "Envio no encontrado!"
    redirect_to shipments_path
  end

  # Fix: Fetch received item counts correctly
  @received_counts = @shipment.received_items.group(:barcode).sum(:quantity)
end





end
