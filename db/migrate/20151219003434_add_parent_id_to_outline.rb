class AddParentIdToOutline < ActiveRecord::Migration
  def change
    change_table :outlines do |t|
      t.integer :parent_id, index: true
    end
  end
end
