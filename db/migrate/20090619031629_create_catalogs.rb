class CreateCatalogs < ActiveRecord::Migration
  def self.up
    create_table :catalogs do |t|
      t.string :sku
      t.string :item
      t.string :description
      t.string :picture
      t.string :price
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs
  end
end
