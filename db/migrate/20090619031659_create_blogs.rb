class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.references :user
      t.string :title
      t.text :post
      t.integer :total_score
      t.integer :votes

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
