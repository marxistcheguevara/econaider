class AddDiscountRateToFactors < ActiveRecord::Migration
  def self.up
    change_table :factors do |t|
      t.decimal :discount_rate
    end
  end

  def self.down
    change_table :factors do |t|
      t.remove :discount_rate
    end
  end
end
