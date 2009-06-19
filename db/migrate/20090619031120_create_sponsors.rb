class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :code
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :motto
      t.text :summary

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsors
  end
end
