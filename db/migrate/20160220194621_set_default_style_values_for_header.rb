class SetDefaultStyleValuesForHeader < ActiveRecord::Migration
  def up
    change_column_default(:headers, :bold, false)
    change_column_default(:headers, :italic, false)
    change_column_default(:headers, :underline, false)
  end

  def down
    change_column_default(:headers, :bold, nil)
    change_column_default(:headers, :italic, nil)
    change_column_default(:headers, :underline, nil)
  end
end
