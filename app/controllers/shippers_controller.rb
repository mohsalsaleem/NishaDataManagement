class ShippersController < ApplicationController
  before_action :set_shipper, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /shippers
  # GET /shippers.json
  $ref = false
  def index
    @shippers = Shipper.all
  end

  # GET /shippers/1
  # GET /shippers/1.json
  def show
  end

  # GET /shippers/new
  def new
    @shipper = Shipper.new
    $ref = URI.parse(request.env["HTTP_REFERER"]).to_s.include?("orders")
  end

  # GET /shippers/1/edit
  def edit
  end

  # POST /shippers
  # POST /shippers.json
  def create
    @shipper = Shipper.new(shipper_params)

    respond_to do |format|
      if @shipper.save
        if $ref
          # redirect_to new_order_path
          format.html { redirect_to new_order_path, notice: 'Shipper was successfully created.' }
        else
          format.html { redirect_to @shipper, notice: 'Shipper was successfully created.' }
        end
        format.json { render :show, status: :created, location: @shipper }
      else
        format.html { render :new }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shippers/1
  # PATCH/PUT /shippers/1.json
  def update
    respond_to do |format|
      if @shipper.update(shipper_params)
        format.html { redirect_to @shipper, notice: 'Shipper was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper }
      else
        format.html { render :edit }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shippers/1
  # DELETE /shippers/1.json
  def destroy
    @shipper.destroy
    respond_to do |format|
      format.html { redirect_to shippers_url, notice: 'Shipper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper
      @shipper = Shipper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_params
      params.require(:shipper).permit(:name, :address_line_1, :address_line_2, :city, :country, :tel_no, :email)
    end
end
