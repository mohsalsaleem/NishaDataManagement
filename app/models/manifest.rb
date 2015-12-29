class Manifest < ActiveRecord::Base
  belongs_to :order
  # alidates_presence_of :mawb, :order_id
  def self.search(query)
  	if query
  		return Manifest.all.where(mawb: query)
  	else
  		return Manifest.all
  	end
  end
end
