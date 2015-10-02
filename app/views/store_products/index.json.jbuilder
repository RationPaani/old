json.array!(@store_products) do |store_product|
  json.extract! store_product, :id, :user_id, :product_id, :price, :stock, :in_w, :in_r
  json.url store_product_url(store_product, format: :json)
end
