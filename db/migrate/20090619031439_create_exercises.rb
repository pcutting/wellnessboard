class CreateExercises < ActiveRecord::Migration
  def self.up
    create_table :exercises do |t|
      t.references :user
      t.string :title
      t.decimal :length
      t.integer :calories
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :exercises
  end
end
