class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.references :user
      t.decimal :weight
      t.decimal :chest
      t.decimal :belly_upper
      t.decimal :belly_lower
      t.decimal :hips
      t.decimal :thigh
      t.decimal :arm
      t.integer :water
      t.integer :steps_daily
      t.integer :daily_calories

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
