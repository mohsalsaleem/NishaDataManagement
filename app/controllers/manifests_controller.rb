class ManifestsController < ApplicationController
  before_action :set_manifest, only: [:show, :edit, :update, :destroy]

  # GET /manifests
  # GET /manifests.json
  def index
    @manifests = Manifest.all
  end

  # GET /manifests/1
  # GET /manifests/1.json
  def show
  end

  # GET /manifests/new
  def new
    @manifest = Manifest.new
  end

  # GET /manifests/1/edit
  def edit
  end

  # POST /manifests
  # POST /manifests.json
  def create
    @manifest = Manifest.new(manifest_params)
    #print manifest_params[:order_id]
    order_array = []
    hawb_number_array = []

    for i in 0..manifest_params[:order_id].length-2
      order_array.push(manifest_params[:order_id][i].to_i)
    end

    orders = Order.find(order_array)
    # print orders.first.hawb_number
    orders.each do |o|
      hawb_number_array.push(o.hawb_number.to_s)
    end

    @manifest.orders_to_manifest = order_array
    @manifest.hawb_numbers_to_manifest = hawb_number_array

    respond_to do |format|
      if @manifest.save
        format.html { redirect_to @manifest, notice: 'Manifest was successfully created.' }
        format.json { render :show, status: :created, location: @manifest }
      else
        format.html { render :new }
        format.json { render json: @manifest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manifests/1
  # PATCH/PUT /manifests/1.json
  def update
    order_array = []
    hawb_number_array = []
    for i in 0..manifest_params[:order_id].length-2
      order_array.push(manifest_params[:order_id][i].to_i)
    end

    orders = Order.find(order_array)
    
    orders.each do |o|
      hawb_number_array.push(o.hawb_number.to_s)
    end

    @manifest.orders_to_manifest = order_array
    @manifest.hawb_numbers_to_manifest = hawb_number_array
    
    respond_to do |format|
      if @manifest.update(manifest_params)
        format.html { redirect_to @manifest, notice: 'Manifest was successfully updated.' }
        format.json { render :show, status: :ok, location: @manifest }
      else
        format.html { render :edit }
        format.json { render json: @manifest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manifests/1
  # DELETE /manifests/1.json
  def destroy
    @manifest.destroy
    respond_to do |format|
      format.html { redirect_to manifests_url, notice: 'Manifest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manifest
      @manifest = Manifest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manifest_params
      params.require(:manifest).permit(:mawb, { :order_id => [] } )
    end
end
