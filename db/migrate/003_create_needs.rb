class CreateNeeds < ActiveRecord::Migration
  def self.up
    create_table :needs do |t|
      t.string :name
      t.integer :price
      t.integer :line_id
      t.timestamps
    end
  end

  def self.down
    drop_table :needs
  end
end
