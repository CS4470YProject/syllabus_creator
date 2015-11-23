class CreateTemplates < ActiveRecord::Migration
  def change
    change_table :outlines do |t|
      t.string :type
    end
  end
end
