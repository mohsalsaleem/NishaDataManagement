class Order < ActiveRecord::Base
  belongs_to :shipper
  belongs_to :consignee
end
