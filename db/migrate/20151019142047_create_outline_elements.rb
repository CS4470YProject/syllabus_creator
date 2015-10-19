class CreateOutlineElements < ActiveRecord::Migration
  def change
    create_table :outline_elements do |t|
      t.references :outline, index: true
      t.references :element, index: true
      t.timestamps null: false
    end
  end
end
