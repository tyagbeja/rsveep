class AddStatusColumnToEventsTable < ActiveRecord::Migration
  def up
    add_column :events, :status, :string, :default => 'active'
  end
  def down
    remove_column :events, :status, :string
  end
end
