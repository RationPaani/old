class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites, id: false do |t|
    t.belongs_to :user
    t.belongs_to :store
    end
  end
end
