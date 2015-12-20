class Consignee < ActiveRecord::Base
	has_one :shipment
end
