class AddFacultyIdtoDepartment < ActiveRecord::Migration
  def change
    change_table :departments do |t|
      t.references :faculty
    end
  end
end
