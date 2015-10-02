class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections, id: false do |t|
    t.belongs_to :store
    end
  end
end