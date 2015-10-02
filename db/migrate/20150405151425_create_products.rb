class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :user, index: true
      t.string :name, null: false, default: ""
      t.string :brand
      t.string :category
      t.string :image
      t.string :unit # kg in case of loose products like rice
      t.string :spec # box of 50 packets etc.
      t.decimal :price, null: false, default: 100.0 # rate in case of services
      t.string :typ #type of store it will be sold in

      t.timestamps null: false
    end
  end
end
