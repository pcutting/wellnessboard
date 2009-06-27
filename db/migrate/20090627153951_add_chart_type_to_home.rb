class AddChartTypeToHome < ActiveRecord::Migration
  def self.up
    add_column :homes, :chart_type, :string
  end

  def self.down
    remove_column :homes, :chart_type
  end
end
