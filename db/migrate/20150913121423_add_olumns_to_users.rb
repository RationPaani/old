class AddOlumnsToUsers < ActiveRecord::Migration
def change
    remove_column :users, :coins, :integer
  end
end
