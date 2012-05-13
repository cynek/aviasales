class AddHopsCountAndWayDurationToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :hops_count, :integer, :null => false, :default => 0
    add_index :flights, :hops_count
    add_column :flights, :way_duration, :integer, :null => false, :default => 0
    add_index :flights, :way_duration
  end
end
