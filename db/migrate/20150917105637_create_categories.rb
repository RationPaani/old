class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
     t.belongs_to :store
      t.string :name
      t.string :subcats, array:true, default: []
      t.string :filterables, array:true, default: []

      t.timestamps null: false
    end
  end
end
