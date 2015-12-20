class Shipper < ActiveRecord::Base
	has_one :shipment
end
