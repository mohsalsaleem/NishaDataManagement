json.array!(@shippers) do |shipper|
  json.extract! shipper, :id, :name, :address_line_1, :address_line_2, :city, :country, :tel_no, :email
  json.url shipper_url(shipper, format: :json)
end
