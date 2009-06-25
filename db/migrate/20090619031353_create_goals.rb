class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.references :user
      t.decimal :weight, :default => 0
      t.decimal :chest, :default => 0
      t.decimal :belly_upper, :default => 0
      t.decimal :belly_lower, :default => 0
      t.decimal :hips, :default => 0
      t.decimal :thigh, :default => 0
      t.decimal :arm, :default => 0
      t.integer :water , :default => 64
      t.integer :steps_daily, :default => 3000
      t.integer :daily_calories, :default => 1250
      t.datetime :date, :default => Date.current

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
