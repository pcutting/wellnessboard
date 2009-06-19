class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.references :user
      t.decimal :chest
      t.decimal :belly_upper
      t.decimal :belly_lower
      t.decimal :hips
      t.decimal :thigh
      t.decimal :arm

      t.timestamps
    end
  end

  def self.down
    drop_table :measurements
  end
end
