class AddPrevHopIdToHops < ActiveRecord::Migration
  def change
    add_column :hops, :prev_hop_id, :integer
    add_index :hops, :prev_hop_id
  end
end
