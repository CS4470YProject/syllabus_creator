class AddDepartmentIdToOutline < ActiveRecord::Migration
  def change
    change_table :outlines do |t|
      t.references :department
    end
  end
end
