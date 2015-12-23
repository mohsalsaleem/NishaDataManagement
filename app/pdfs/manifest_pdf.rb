require 'encapsulate'
class ManifestPdf < Prawn::Document
	def initialize(orders,manifest,baggages)
		super(top_margin: 50)
		@orders = orders
		@manifest = manifest
		@baggages = baggages
		@data = Encapsulate.new(orders,manifest,baggages)
		mawb_number
	end

	def mawb_number
		text "Manifest \##{@manifest.mawb}", size: 20, style: :bold
		manifest_orders
	end

	def manifest_orders
		move_down 20

		# puts "Saleem"
		# puts @data
		orders_row
	end

	def orders_row
		number_of_orders = @orders.length
		print number_of_orders
		outer_array = ["1","2","3","4","5","6","7"]
		
		table [["HAWB","SHIPPER","CONSIGNEE","PCS","BAG WT","CONTENT","AED"]] + 
				[["1","2","3","4","5","6","7"]]


	end
end