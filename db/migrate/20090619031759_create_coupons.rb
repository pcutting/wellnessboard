class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.references :order
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
