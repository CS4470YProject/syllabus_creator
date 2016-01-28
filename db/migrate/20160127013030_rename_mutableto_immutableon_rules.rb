class RenameMutabletoImmutableonRules < ActiveRecord::Migration
  def up
    rename_column :rules, :mutable, :immutable
    change_column_default :rules, :immutable, false
  end
  def down
    rename_column :rules, :immutable, :mutable
    change_column_default :rules, :mutable, true
  end
end

