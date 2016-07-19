class AddPercentageToRooms < ActiveRecord::Migration
  def self.up
    change_table :rooms do |t|
      t.integer :percentage
    end
  end

  def self.down
    change_table :rooms do |t|
      t.remove :percentage
    end
  end
end
