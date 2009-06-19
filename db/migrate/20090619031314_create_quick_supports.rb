class CreateQuickSupports < ActiveRecord::Migration
  def self.up
    create_table :quick_supports do |t|
      t.references :user
      t.integer :priority
      t.string :title
      t.text :details
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :quick_supports
  end
end
