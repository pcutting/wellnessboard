class CreateOfferSkus < ActiveRecord::Migration
  def self.up
    create_table :offer_skus do |t|
      t.references :promotion
      t.string :sku

      t.timestamps
    end
  end

  def self.down
    drop_table :offer_skus
  end
end
