class CreateFactors < ActiveRecord::Migration
  def self.up
    create_table :factors do |t|
      t.integer :economic_year
      t.decimal :inflation_rate
      t.decimal :tax_rate
      t.timestamps
    end
  end

  def self.down
    drop_table :factors
  end
end
