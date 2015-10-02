class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.integer :storetype
      t.string :image
      t.text :detail
      t.text :offer
      t.string :state, null: false, default: ""
      t.string :city, null: false, default: ""
      t.string :zip
      t.string :add1, null: false, default: ""
      t.string :add2
      t.float :latitude
      t.float :longitude
      t.integer :subcription
      t.boolean :enable, null: false, default: true
      t.text :oparea
      t.integer :opradius
      t.integer :referer
      t.decimal :thrusold, null: false, default: 100.0

      t.timestamps null: false
    end
  end
end	
