class CreateMyFoods < ActiveRecord::Migration
  def self.up
    create_table :my_foods do |t|
      t.references :user
      t.string :name
      t.integer :calories
      t.integer :protein

      t.timestamps
    end
  end

  def self.down
    drop_table :my_foods
  end
end
