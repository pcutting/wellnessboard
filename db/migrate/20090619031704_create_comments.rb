class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user
      t.text :response
      t.integer :total_score
      t.integer :votes

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
