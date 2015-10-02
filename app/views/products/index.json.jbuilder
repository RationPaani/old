json.array!(@products) do |product|
  json.extract! product, :id, :name, :brand, :category, :image, :unit, :spec, :price
  json.url product_url(product, format: :json)
end
