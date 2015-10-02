class CreateStoreProducts < ActiveRecord::Migration
 
  def change
    create_table :store_products do |t|
      t.belongs_to :store, index: true
      t.belongs_to :product, index: true
      t.decimal :price, null: false, default: 100.0 # or rate
      t.integer :stock, null: false, default: 100 # or number
      t.text :description

      t.timestamps null: false
    end
  #add_index :store_products, [:store_id, :product_id], unique: true
  end
end
