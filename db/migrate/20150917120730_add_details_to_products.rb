class AddDetailsToProducts < ActiveRecord::Migration
  def change
    rename_column :products, :user_id, :store_id
    add_column :products, :stock, :integer
    add_column :products, :specs, :hstore
  end
end
