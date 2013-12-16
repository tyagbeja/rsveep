class AddGcmColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :gcmid, :string
  end
  def down
    remove_column :users, :gcmid, :string
  end
end
