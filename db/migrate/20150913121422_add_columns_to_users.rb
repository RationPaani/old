class AddColumnsToUsers < ActiveRecord::Migration
def change
    add_column :users, :coins, :integer, :default => 0
    add_column :users, :subscription, :integer, :default => 0
  end
end
