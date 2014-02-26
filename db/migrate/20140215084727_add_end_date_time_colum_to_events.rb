class AddEndDateTimeColumToEvents < ActiveRecord::Migration
  def up
    add_column :events, :endDateTime, :datetime
  end
  def down
    remove_column :events, :endDateTime, :datetime
  end
end
