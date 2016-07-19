class CreateStrategies < ActiveRecord::Migration
  def self.up
    create_table :strategies do |t|
      t.string :name
      t.integer :price
      t.integer :line_id
      t.timestamps
    end
  end

  def self.down
    drop_table :strategies
  end
end
