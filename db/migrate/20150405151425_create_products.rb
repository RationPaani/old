class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :store, index: true
      t.string :name, null: false, default: ""
      t.string :brand
      t.string :image
      t.string :unit # kg in case of loose products like rice
      t.decimal :price, null: false, default: 100.0 # rate in case of services
      t.integer :stock
      t.integer :category

      t.timestamps null: false
    end
  end
end
