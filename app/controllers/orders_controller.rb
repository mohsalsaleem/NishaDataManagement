require 'json'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.order('hawb_number DESC').paginate(:page => params[:page], per_page: 6)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    @order.hawb_number = Hawb.first.number + 1

    @order.baggage_data = JSON.parse(order_params[:baggage_data])

    print eval(@order.baggage_data["1"]).class

    respond_to do |format|
      if @order.save
        Hawb.first.update(number: @order.hawb_number)
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.baggage_data = eval(order_params[:baggage_data])
    print order_params[:baggage_data]
    respond_to do |format|
      if @order.update(order_params)
        @order.update(baggage_data: eval(order_params[:baggage_data]))
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add
    print "Saleem"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:hawb_number, :shipper_id, :consignee_id, :total_pieces, :total_weight, :items_cost, :content, :baggage_data)
    end
end
