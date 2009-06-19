class CreateWeights < ActiveRecord::Migration
  def self.up
    create_table :weights do |t|
      t.references :user
      t.datetime :date
      t.decimal :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :weights
  end
end
