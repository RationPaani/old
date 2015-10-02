class AddModsToStore < ActiveRecord::Migration
  def change
  	remove_column :stores, :storetype, :integer
  	add_column :stores, :storetype, :string
  end
end
