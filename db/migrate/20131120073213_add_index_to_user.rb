class AddIndexToUser < ActiveRecord::Migration
  def up
    add_index :users, :number, :unique => true
  end

  def down
    remove_index :users, :column => :number
  end
end
