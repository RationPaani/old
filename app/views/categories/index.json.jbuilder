json.array!(@categories) do |category|
  json.extract! category, :id, :belongs_to, :name, :subcats, :filterables
  json.url category_url(category, format: :json)
end
