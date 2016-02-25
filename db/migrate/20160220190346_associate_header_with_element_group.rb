class AssociateHeaderWithElementGroup < ActiveRecord::Migration
  def change
    change_table :headers do |t|
      t.references :element_group
    end
  end
end
