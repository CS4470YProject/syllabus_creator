class AddFieldsToRule < ActiveRecord::Migration
  def change
    change_table :rules do |t|
      t.boolean :mutable, default: true
      t.boolean :required, default: false
    end
  end
end
