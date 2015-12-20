json.array!(@consignees) do |consignee|
  json.extract! consignee, :id, :name, :address_line_1, :address_line_2, :po_box_no, :city, :country, :tel_no_1, :tel_no_2, :email
  json.url consignee_url(consignee, format: :json)
end
