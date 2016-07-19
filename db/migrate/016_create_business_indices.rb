class CreateBusinessIndices < ActiveRecord::Migration
  def self.up
    create_table :business_indices do |t|
      t.string :name
      t.decimal :inc_rate
      t.string :text_fitness
      t.string :text_education
      t.string :text_bookstore
      t.timestamps
    end
  end

  def self.down
    drop_table :business_indices
  end
end
