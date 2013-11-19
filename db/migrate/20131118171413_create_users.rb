class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :number
      t.boolean :verified
      
      t.timestamps
    end
  end  
end
