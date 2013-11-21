class AddIndexToEvent < ActiveRecord::Migration
  def up
    add_index :events, :eventId, :unique => true
  end

  def down
    remove_index :events, :eventId => :number
  end
end
