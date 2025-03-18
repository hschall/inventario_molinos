class PosController < ApplicationController
  before_action :set_po, only: %i[ show edit update destroy ]

  # GET /pos or /pos.json
  def index
    @pos = Po.all
  end

  # GET /pos/1 or /pos/1.json
  def show
  end

  # GET /pos/new
  def new
    @po = Po.new
  end

  # GET /pos/1/edit
  def edit
  end

  # POST /pos or /pos.json
  def create
    @po = Po.new(po_params)

    respond_to do |format|
      if @po.save
        format.html { redirect_to @po, notice: "Sucursal creada con exito" }
        format.json { render :show, status: :created, location: @po }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @po.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos/1 or /pos/1.json
  def update
    respond_to do |format|
      if @po.update(po_params)
        format.html { redirect_to @po, notice: "Po was successfully updated." }
        format.json { render :show, status: :ok, location: @po }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @po.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos/1 or /pos/1.json
  def destroy
  begin
    @po.destroy!
    flash[:success] = "POS was successfully deleted."
  rescue ActiveRecord::InvalidForeignKey
    flash[:error] = "Cannot delete POS because it has associated shipments or records."
  end

  respond_to do |format|
    format.html { redirect_to pos_path, status: :see_other }
    format.json { head :no_content }
  end
end

def dashboard
  @pos_locations = Po.all.includes(:shipments) # Load POS locations with shipments

  @shipment_status_counts = {}
  @pos_locations.each do |pos|
    @shipment_status_counts[pos.id] = {
      total: pos.shipments.count,
      pending: pos.shipments.where(status: "Pending").count,
      in_transit: pos.shipments.where(status: "In Transit").count,
      arrived: pos.shipments.where(status: "Arrived").count, # ✅ Fix: Use correct status
      completed: pos.shipments.where(status: "Completed").count
    }
  end
end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_po
      @po = Po.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def po_params
      params.require(:po).permit(:name, :address, :cp, :ruta)
    end
end
