class CreateTestimonies < ActiveRecord::Migration
  def self.up
    create_table :testimonies do |t|
      t.string :photo
      t.string :name
      t.string :layout
      t.boolean :public
      t.string :title
      t.text :comment
      t.integer :points
      t.integer :votes
      t.integer :before
      t.integer :after
      t.integer :display_value
      t.boolean :approved

      t.timestamps
    end
  end

  def self.down
    drop_table :testimonies
  end
end
