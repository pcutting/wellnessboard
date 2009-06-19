class CreateBodyScans < ActiveRecord::Migration
  def self.up
    create_table :body_scans do |t|
      t.references :user
      t.integer :water
      t.integer :metabolism
      t.integer :visc
      t.integer :fat
      t.integer :muscle

      t.timestamps
    end
  end

  def self.down
    drop_table :body_scans
  end
end
