json.array!(@orders) do |order|
  json.extract! order, :id, :order, :buyer_id, :user_id, :product_id, :quantity, :logistic_id, :bresponse, :sresponse, :lresponse, :bvis, :svis, :lvis
  json.url order_url(order, format: :json)
end
