class CreateStaffs < ActiveRecord::Migration
  def self.up
    create_table :staffs do |t|
      t.string :name
      t.integer :wage
      t.integer :line_id
      t.timestamps
    end
  end

  def self.down
    drop_table :staffs
  end
end
