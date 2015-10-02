class CreateCatsubs < ActiveRecord::Migration
  def change
    create_table :catsubs, id: false do |t|
    t.belongs_to :category
    t.belongs_to :subcate
    end
  end
end
