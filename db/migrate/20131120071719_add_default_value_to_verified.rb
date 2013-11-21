class AddDefaultValueToVerified < ActiveRecord::Migration
  def up
    change_column :users, :verified, :boolean, :default => false
  end

  def down
    change_column :users, :verified, :boolean, :default => nil
  end
end
