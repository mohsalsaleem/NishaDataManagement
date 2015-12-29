class ManifestsController < ApplicationController
  before_action :set_manifest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /manifests
  # GET /manifests.json
  def index
    if params[:search].present?
      result = Manifest.search(params[:search])
      @manifests = result.paginate(page: params[:page], per_page: 10)
    else
      @manifests = Manifest.paginate(page: params[:page], per_page: 10)
    end
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
    orders_to_update = []

    for i in 0..manifest_params[:order_id].length-2
      order_array.push(manifest_params[:order_id][i].to_i)
    end

    orders = Order.find(order_array)
    # print orders.first.hawb_number
    orders.each do |o|
      hawb_number_array.push(o.hawb_number.to_s)
      orders_to_update.push(o.id)
    end

    @manifest.orders_to_manifest = order_array
    @manifest.hawb_numbers_to_manifest = hawb_number_array

    respond_to do |format|
      if @manifest.save
        orders_to_update.each do |otu|
          order = Order.find(otu)
          order.update(manifested_flag: true)
        end
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


  def view_manifest
    mawb = manifest_params[:mawb]
    @manifest = Manifest.find_by(mawb: mawb)
    orders_to_manifest = @manifest.orders_to_manifest
    @orders = Order.find(orders_to_manifest)
    remaing_weight = 0
    remaining_weight_baggage = {}
    last_baggage_number = 0
    baggage_list = {}

    flag = true

    @orders.each do |o|
      pieces_array = [] 
      single_piece_detail = {}
      last_baggage_number += 1
      decimal = 0
      pieces = o.total_weight/30
      s_pieces = pieces.floor
      puts "Pieces: " + s_pieces.to_s
      
      start = last_baggage_number
      last_baggage_number = s_pieces + start -1

      # puts "remaing_weight: " + remaing_weight.ceil.to_s
      # puts "Order total weight: " + o.total_weight.to_s
    
      # puts "start: " + start.to_s
      # puts "last_baggage_number: " + last_baggage_number.to_s
      for i in start.to_i..last_baggage_number.to_i
        single_piece_detail[i.to_s] = 30
      end

      # pieces_array.push(single_piece_detail)
      # print "saleem"

      if pieces % 1 != 0
        puts "Pieces dec: " + pieces.to_s
        decimal = pieces - pieces.floor
        # puts "Decimal: " + decimal.to_s
        remaing_weight = (decimal * 30)

        puts "Balance: " + remaing_weight.to_s

        remaining_weight_baggage.each do |k,v|

          weight = v.to_i + remaing_weight

          # puts "Weight: "+weight.round.to_s
          

          if weight.to_i <= 32
            # puts k.to_s
            # puts remaing_weight
            # puts v.to_i
            if v.to_i > 2
              single_piece_detail[k.to_s] = remaing_weight.to_i
              remaining_weight_baggage[k.to_s] = v - remaing_weight
              puts "Remaining Weight baggage: " + remaining_weight_baggage[k.to_s].to_s 
              # puts "remaing_weight: " + (remaing_weight - v).to_s
              flag = false
            end
          end
        end

        remaining_weight_baggage.each do |r,vv|
          puts r.to_s + ":" + vv.to_s
        end

        if flag
          last_baggage_number += 1
          remaining_weight_baggage[last_baggage_number.to_i.to_s] = remaing_weight
          single_piece_detail[last_baggage_number.to_s] = remaing_weight.to_i
          pieces += 1
        end
        flag = true
      end
      # pieces_array.push(single_piece_detail)
      # puts pieces_array
      
      baggage_list[o.hawb_number.to_s] = single_piece_detail
      # baggage_list = single_piece_detail
      # remain
    end

    puts baggage_list

    @baggages = baggage_list
    # puts remaining_weight_baggage
    # puts "pieces_array:"
    # puts pieces_array
    # return [@orders,@manifest,@baggages]
    clr = caller[0][/`.*'/][1..-2]
    if clr == "block (2 levels) in download"
      return
    else 
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Manifest",
                template: 'manifests/view_manifest.pdf.erb',
                layout: 'pdf.html.erb',
               margin:  {   top:               5,                     # default 10 (mm)
                            bottom:            10,
                            left:              10,
                            right:             10 }  # Excluding ".pdf" extension.
        end
      end
    end
    
  end


  def download
    respond_to do |format|
      format.xlsx do
        render xslx: view_manifest, filename: "Manifest_#{@manifest.mawb}"
      end
    end
  end

  # def download_xls
  #   respond_to do |format|
  #     format.html
  #     format.xlsx { render xlsx: :index, filename: "my_items_doc" }
  #   end
  # end


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
