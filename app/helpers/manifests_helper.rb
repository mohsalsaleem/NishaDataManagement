module ManifestsHelper
	def to_upcase(word)
		return word.upcase
	end
	def to_string(number)
		return number.to_s
	end
	def orders_not_manifested_yet
		return Order.all.where(manifested_flag: false)
	end
	def to_hash(value)
		val = eval(value)
		return val
	end
end
