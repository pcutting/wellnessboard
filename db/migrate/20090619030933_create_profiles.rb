class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      t.text :shipping_address
      t.text :physical_address
      t.string :sponsor
      t.string :coach
      t.string :referred_by
      t.string :phone
      t.string :alt_phone
      t.integer :hight
      t.string :time_zone

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
