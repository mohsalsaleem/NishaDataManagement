class Order < ActiveRecord::Base
  belongs_to :shipper
  belongs_to :consignee
  validates_uniqueness_of :hawb_number
end
