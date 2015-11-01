class AddCourseIdToOutline < ActiveRecord::Migration
  def change
    change_table :outlines do |t|
      t.references :course, index: true
    end
  end
end
