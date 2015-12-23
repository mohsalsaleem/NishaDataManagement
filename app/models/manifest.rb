class Manifest < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :mawb, :order_id
end
