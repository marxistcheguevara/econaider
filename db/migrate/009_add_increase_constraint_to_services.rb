class AddIncreaseConstraintToServices < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.integer :increase_constraint
    end
  end

  def self.down
    change_table :services do |t|
      t.remove :increase_constraint
    end
  end
end
