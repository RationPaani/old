class CraeteTracking < ActiveRecord::Migration
  def change
  create_table :trackings do |t|
      t.belongs_to :order, index: true
      t.integer :user
      t.text :location

      t.timestamps null: false
  end
end
end
