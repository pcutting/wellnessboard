class CreateOfferRestrictions < ActiveRecord::Migration
  def self.up
    create_table :offer_restrictions do |t|
      t.references :promotion
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :offer_restrictions
  end
end
