class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.decimal :price, :precision => 12, :scale => 2

      t.timestamps
    end
  end
end
