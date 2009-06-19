class CreatePromotions < ActiveRecord::Migration
  def self.up
    create_table :promotions do |t|
      t.string :code
      t.references :offer_sku
      t.integer :percent
      t.boolean :accumulative
      t.boolean :all_access
      t.references :offer_restriction
      t.references :offer_access
      t.datetime :start
      t.datetime :end
      t.text :description
      t.references :sponsor
      t.boolean :all_sponsors

      t.timestamps
    end
  end

  def self.down
    drop_table :promotions
  end
end
