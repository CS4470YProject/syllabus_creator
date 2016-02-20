class AddTextToElement < ActiveRecord::Migration
  def change
    change_table :elements do |t|
      t.text :text
    end
  end
end
