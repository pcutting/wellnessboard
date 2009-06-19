class CreateShakeRecipes < ActiveRecord::Migration
  def self.up
    create_table :shake_recipes do |t|
      t.string :name
      t.text :description
      t.integer :calories
      t.string :protein

      t.timestamps
    end
  end

  def self.down
    drop_table :shake_recipes
  end
end
