class CreateMyExercises < ActiveRecord::Migration
  def self.up
    create_table :my_exercises do |t|
      t.references :user
      t.string :title
      t.decimal :length
      t.integer :calories

      t.timestamps
    end
  end

  def self.down
    drop_table :my_exercises
  end
end
