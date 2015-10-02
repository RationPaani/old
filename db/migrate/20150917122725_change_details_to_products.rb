class ChangeDetailsToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :category, :string
    add_column :products, :category, :integer
    remove_column :products, :spec, :string
    remove_column :products, :typ, :string
  end
end
