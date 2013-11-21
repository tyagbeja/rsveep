class CreateGuests < ActiveRecord::Migration
  def up
    create_table :guests do |t|
      t.belongs_to :event
      t.string :user
      t.string :response
      t.string :notes
      t.timestamps
    end
  end
  
  def down
    drop_table :guests
  end
end
