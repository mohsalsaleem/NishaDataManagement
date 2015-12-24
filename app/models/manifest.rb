class Manifest < ActiveRecord::Base
  belongs_to :order
  # alidates_presence_of :mawb, :order_id
end
