require 'json'
module OrdersHelper
	def to_hash(value)
		val = eval(value)
		return val
	end
end
