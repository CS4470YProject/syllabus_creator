class CreateElementGroups < ActiveRecord::Migration
  def change
    create_table :element_groups do |t|
      t.integer :rank
      t.references :outline
      t.timestamps null: false
    end
  end
end
