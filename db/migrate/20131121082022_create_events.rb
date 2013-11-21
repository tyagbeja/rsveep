class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.belongs_to :user
      t.string    :eventId
      t.string    :type , :null => true
      t.string    :title
      t.string    :subtitle , :null => true
      t.string    :venue
      t.string    :address , :null => true
      t.string    :city , :null => true
      t.string    :state , :null => true
      t.string    :country , :null => true
      t.string    :postcode , :null => true
      t.decimal    :longitude
      t.decimal    :latitude
      t.datetime  :dateTime
      t.string    :dressing , :null => true
      t.text      :notes , :null => true
      t.string    :privacy
      t.string    :image , :null => true
      
      t.timestamps
    end
  end
  
  def down
    drop_table :events
  end
end
