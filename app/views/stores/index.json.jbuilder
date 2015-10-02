json.array!(@stores) do |store|
  json.extract! store, :id, :store_type, :store_name, :store_image, :store_detail, :store_offer, :state, :city, :zip, :add1, :add2, :subs_status, :enable
  json.url store_url(store, format: :json)
end
