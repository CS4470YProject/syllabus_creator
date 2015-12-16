class AddOrderToOutlineElements < ActiveRecord::Migration
  def change
    change_table :outline_elements do |t|
      t.integer :order
    end
  end
end
