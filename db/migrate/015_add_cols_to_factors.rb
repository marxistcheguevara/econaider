class AddColsToFactors < ActiveRecord::Migration
  def self.up
    change_table :factors do |t|
      t.decimal :optimistic_rate
    t.decimal :pessimistic_rate
    end
  end

  def self.down
    change_table :factors do |t|
      t.remove :optimistic_rate
    t.remove :pessimistic_rate
    end
  end
end
