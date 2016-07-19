class AddLineIdToServices < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.integer :line_id
    end
  end

  def self.down
    change_table :services do |t|
      t.remove :line_id
    end
  end
end
