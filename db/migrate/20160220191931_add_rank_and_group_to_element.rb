class AddRankAndGroupToElement < ActiveRecord::Migration
  def change
    change_table :elements do |t|
      t.integer :rank, default: 0
      t.references :element_group
    end
  end
end
