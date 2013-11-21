class CreateVerifications < ActiveRecord::Migration
  def up
    create_table :verifications do |t|
      t.string :number
      t.string :code
      t.timestamps
    end
    
    add_index "verifications", ["number"], name: "index_verifications_on_number", unique: true, using: :btree
  end
  
  def down
    drop_table :verifications
  end
end
