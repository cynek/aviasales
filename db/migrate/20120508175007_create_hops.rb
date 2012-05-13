class CreateHops < ActiveRecord::Migration
  def change
    create_table :hops do |t|
      t.decimal :latstart, :precision => 8, :scale => 6, :null => false
      t.decimal :lonstart, :precision => 9, :scale => 6, :null => false
      t.decimal :latend, :precision => 8, :scale => 6, :null => false
      t.decimal :lonend, :precision => 9, :scale => 6, :null => false
      t.datetime :date, :null => false
      t.integer :duration, :null => false
      t.references :flight, :null => false

      t.timestamps
    end
    add_index :hops, :flight_id
    add_index :hops, :date

  end
end
