class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.references :user
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.string :billing_address
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip
      t.string :sponsor
      t.string :coach
      t.string :referred_by
      t.string :phone
      t.string :alt_phone
      t.integer :hight_feet
      t.integer :hight_inches
      t.string :time_zone
      t.string :nick_name
      t.string :name_first
      t.string :middle_initial
      t.string :name_last
      t.string :sufix
      t.date :dob
      

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
