class AddTimeSpanToHome < ActiveRecord::Migration
  def self.up
    add_column :homes, :time_span_days, :integer
  end

  def self.down
    remove_column :homes, :time_span_days
  end
end
