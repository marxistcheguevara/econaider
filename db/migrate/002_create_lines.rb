class CreateLines < ActiveRecord::Migration
  def self.up
    create_table :lines do |t|
      t.string :name
      t.integer :p_index
      t.integer :cs_index
      t.timestamps
    end
  end

  def self.down
    drop_table :lines
  end
end
