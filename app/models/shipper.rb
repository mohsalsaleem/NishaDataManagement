class Shipper < ActiveRecord::Base
	has_many :orders, dependent: :delete_all
	validates_uniqueness_of :email, :address_line_1, :tel_no
	validates_format_of :email,:with => Devise::email_regexp
end
