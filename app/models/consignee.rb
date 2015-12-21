class Consignee < ActiveRecord::Base
	has_many :orders, dependent: :delete_all
	validates_uniqueness_of :po_box_no,:address_line_1, :email, :tel_no_1
	validates_format_of :email,:with => Devise::email_regexp
end
