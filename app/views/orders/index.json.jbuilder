json.array!(@orders) do |order|
  json.extract! order, :id, :hawb_number, :shipper_id, :consignee_id, :total_weight, :items_cost, :content
  json.url order_url(order, format: :json)
end
