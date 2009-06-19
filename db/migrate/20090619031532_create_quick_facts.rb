class CreateQuickFacts < ActiveRecord::Migration
  def self.up
    create_table :quick_facts do |t|
      t.string :category
      t.string :title
      t.text :summary
      t.string :reference
      t.integer :total_score
      t.integer :votes

      t.timestamps
    end
  end

  def self.down
    drop_table :quick_facts
  end
end
