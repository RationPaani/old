class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :specs, :hstore
  end
end
