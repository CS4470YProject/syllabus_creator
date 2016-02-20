class RenameDepartmenttoCategory < ActiveRecord::Migration
  def up
    rename_table :departments, :categories
    rename_column :outlines, :department_id, :category_id
  end

  def down
    rename_table :categories, :departments
    rename_column :outlines, :category_id, :department_id
  end
end
