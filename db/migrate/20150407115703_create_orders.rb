class CreateOrders < ActiveRecord::Migration
 
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.references :store, index: true
      t.references :logistic, index: true
      t.integer :quantity # total no of \products in order
      t.decimal :ordervalue
      t.text :address
      t.integer :bresponse
      t.integer :sresponse
      t.integer :lresponse
      t.boolean :bvis
      t.boolean :svis
      t.boolean :lvis


      t.timestamps null: false
    end
  end
end
