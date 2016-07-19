class AddFieldsToFactors < ActiveRecord::Migration
  def self.up
    change_table :factors do |t|
      t.decimal :credit_percentage_rate
    end
  end

  def self.down
    change_table :factors do |t|
      t.remove :credit_percentage_rate
    end
  end
end
