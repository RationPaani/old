class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.belongs_to :order, index: true
      t.belongs_to :product, index: true
      t.integer :quantity # multiplicity of the item
      t.decimal :mrp # price per piece
      t.decimal :total # mrp x quantity..for record of total sell value of a product

      t.timestamps null: false
    end
  end
end
